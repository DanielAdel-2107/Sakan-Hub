import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sakan/features/student/home/apartment/models/apartment_model.dart';
import 'package:sakan/features/student/home/apartment/models/university_model.dart';
import 'package:sakan/features/student/home/apartment/view_models/cubit/apartments_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApartmentsCubit extends Cubit<ApartmentsState> {
  final SupabaseClient _supabase = Supabase.instance.client;

  List<UniversityModel> universities = [];
  List<ApartmentModel> _originalAllApartments = []; // مهم جداً للفلتر

  String? myCollegeId;           // college_id بتاع الطالب من profiles
  double maxDistanceKm = 50.0;

  ApartmentsCubit() : super(ApartmentsInitial());

  // ====================== جلب البيانات الأساسية ======================
  Future<void> fetchUniversities() async {
    if (universities.isNotEmpty) return;

    try {
      final data = await _supabase
          .from('universities')
          .select()
          .order('name', ascending: true);

      universities = data.map<UniversityModel>((json) => UniversityModel.fromJson(json)).toList();

      await _fetchMyCollegeId();
    } catch (e) {
      log('Failed to fetch universities: $e');
    }
  }

  Future<void> _fetchMyCollegeId() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return;

      final profile = await _supabase
          .from('profiles')
          .select('college_id')
          .eq('id', user.id)
          .single();

      myCollegeId = profile['college_id'] as String?;
      log('✅ My College ID: $myCollegeId');
    } catch (e) {
      log('Failed to fetch my college_id: $e');
    }
  }

  // ====================== الـ Default الجديد (كلية الطالب) ======================
  Future<void> fetchApartments() async {
    await fetchUniversities();

    if (myCollegeId != null) {
      await fetchApartmentsNearUniversity(myCollegeId!); // ← أقرب لكليته
    } else {
      await _fetchApartmentsByLocation(useUserLocation: true);
    }
  }

  Future<void> fetchApartmentsNearUniversity(String universityId) async {
    await _fetchApartmentsByLocation(universityId: universityId);
  }

  Future<void> _fetchApartmentsByLocation({
    bool useUserLocation = false,
    String? universityId,
  }) async {
    try {
      emit(ApartmentsLoading());
      await fetchUniversities();

      double? targetLat;
      double? targetLng;

      if (useUserLocation) {
        final userPos = await _getUserLocation();
        targetLat = userPos?.latitude;
        targetLng = userPos?.longitude;
      } else if (universityId != null) {
        final uni = universities.firstWhere((u) => u.id == universityId, orElse: () => UniversityModel(id: '', name: ''));
        targetLat = uni.lat;
        targetLng = uni.lng;
      }

      final List<dynamic> data = await _supabase
          .from('apartments')
          .select('''
            *,
            apartment_images (image_url),
            profiles!owner_id (id, full_name, phone, image_url, is_paid)
          ''')
          .eq('is_available', true)
          .order('created_at', ascending: false);

      List<ApartmentModel> apartments = _processApartments(data, targetLat, targetLng);

      if (targetLat != null && targetLng != null) {
        apartments.sort((a, b) => a.distance.compareTo(b.distance));
      }

      _originalAllApartments = List.from(apartments);

      emit(ApartmentsSuccess(apartments: apartments, allApartments: apartments));
    } catch (e) {
      log('Failed to fetch apartments: $e');
      emit(ApartmentsError("حدث خطأ: ${e.toString()}"));
    }
  }

  List<ApartmentModel> _processApartments(List<dynamic> data, double? targetLat, double? targetLng) {
    return data.map((json) {
      double dist = 0.0;
      if (targetLat != null && targetLng != null) {
        dist = Geolocator.distanceBetween(
              targetLat,
              targetLng,
              (json['lat'] as num?)?.toDouble() ?? 0.0,
              (json['lng'] as num?)?.toDouble() ?? 0.0,
            ) /
            1000;
      }
      return ApartmentModel.fromJson(json, dist);
    }).toList();
  }

  // ====================== البحث ======================
  void searchApartments(String query) {
    if (state is! ApartmentsSuccess) return;
    final fullList = _originalAllApartments;

    if (query.isEmpty) {
      emit(ApartmentsSuccess(apartments: fullList, allApartments: fullList));
    } else {
      final filtered = fullList.where((a) => a.title.toLowerCase().contains(query.toLowerCase())).toList();
      emit(ApartmentsSuccess(apartments: filtered, allApartments: fullList));
    }
  }

  void setMaxDistance(double maxDist) {
    maxDistanceKm = maxDist;
    if (state is! ApartmentsSuccess) return;

    final filtered = (maxDist >= 50)
        ? List<ApartmentModel>.from(_originalAllApartments) // ← مهم: دايماً من القائمة الأصلية
        : _originalAllApartments.where((apt) => apt.distance <= maxDist).toList();

    emit(ApartmentsSuccess(apartments: filtered, allApartments: _originalAllApartments));
  }

  void resetFilters() {
    maxDistanceKm = 50.0;
    fetchApartments();
  }

  Future<Position?> _getUserLocation() async {
    try {
      final last = await Geolocator.getLastKnownPosition();
      if (last != null) return last;
      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    } catch (e) {
      log('Failed to get user location: $e');
      return null;
    }
  }

  UniversityModel? getUniversityById(String id) {
    return universities.firstWhere((u) => u.id == id, orElse: () => UniversityModel(id: '', name: ''));
  }
}