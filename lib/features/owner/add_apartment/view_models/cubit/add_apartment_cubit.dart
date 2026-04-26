import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sakan/core/di/dependancy_injection.dart';
import 'package:sakan/core/network/upload_file_to_storage.dart';
import 'package:sakan/features/owner/add_apartment/view_models/cubit/add_apartment_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddApartmentCubit extends Cubit<AddApartmentState> {
  AddApartmentCubit() : super(const AddApartmentState());

  final _supabase = getIt<SupabaseClient>();

  Future<void> getCurrentLocation() async {
    emit(state.copyWith(isLoading: true));

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        _emitError('يرجى تفعيل الوصول للموقع من إعدادات الجهاز');
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      emit(state.copyWith(
        latitude: position.latitude,
        longitude: position.longitude,
        isLoading: false,
      ));
    } catch (e) {
      log('Error getting location: $e');
      emit(state.copyWith(
        latitude: 30.0444, // القاهرة الافتراضية
        longitude: 31.2357,
        isLoading: false,
      ));
    }
  }

  // ── تحديث الموقع (من السحب أو الضغط) ─────────────────
  void updateLocation(double lat, double lng) {
    emit(state.copyWith(latitude: lat, longitude: lng));
  }

  // ── Submit (محدث) ─────────────────────────────
  Future<void> submit({
    required String title,
    required String description,
    required String priceText,
    required String selectedStatus,
    required List<XFile> photos,
    required GlobalKey<FormState> formKey,
  }) async {
    emit(state.copyWith(
      isLoading: true,
      isSuccess: false,
      errorMessage: null,
    ));

    // Client-side validation
    if (title.trim().isEmpty) {
      _emitError('Title is required');
      return;
    }
    if (description.trim().isEmpty) {
      _emitError('Description is required');
      return;
    }
    final price = double.tryParse(priceText.trim());
    if (price == null || price <= 0) {
      _emitError('Please enter a valid price greater than 0');
      return;
    }
    if (photos.isEmpty) {
      _emitError('Please add at least one photo');
      return;
    }
    if (state.latitude == null || state.longitude == null) {
      _emitError('يرجى تحديد موقع الشقة على الخريطة');
      return;
    }

    try {
      final insertResponse = await _supabase
          .from('apartments')
          .insert({
            'owner_id': _supabase.auth.currentUser!.id,
            'title': title.trim(),
            'description': description.trim(),
            'price': price,
            'lat': state.latitude!,
            'lng': state.longitude!,
            'is_available': selectedStatus == 'Available',
          })
          .select('id')
          .single();

      final apartmentId = insertResponse['id'] as String?;

      if (apartmentId == null || apartmentId.isEmpty) {
        throw Exception('Failed to create apartment record');
      }

      // رفع الصور بالتوازي
      if (photos.isNotEmpty) {
        final uploadFutures = photos.map((photo) async {
          final file = File(photo.path);
          final imageUrl = await uploadFileToSupabaseStorage(
            file: file,
            bucketName: 'apartment-images',
          );

          if (imageUrl == null || imageUrl.isEmpty) return;

          await _supabase.from('apartment_images').insert({
            'apartment_id': apartmentId,
            'image_url': imageUrl,
          });
        });

        await Future.wait(uploadFutures);
      }

      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        errorMessage: null,
      ));
    } on PostgrestException catch (e) {
      log('Postgrest error: ${e.message}');
      _emitError(_friendlyPostgrestError(e));
    } catch (e) {
      log('Unexpected error: $e');
      _emitError('Something went wrong. Please try again');
    }
  }

  void _emitError(String message) {
    emit(state.copyWith(
      isLoading: false,
      isSuccess: false,
      errorMessage: message,
    ));
  }

  String _friendlyPostgrestError(PostgrestException e) {
    switch (e.code) {
      case '23505':
        return 'This title is already used. Please choose another.';
      case '23503':
        return 'Invalid reference data. Please contact support.';
      case '42501':
        return 'Permission denied. Please check your account.';
      default:
        return e.message.isNotEmpty ? e.message : 'Database error occurred';
    }
  }
}