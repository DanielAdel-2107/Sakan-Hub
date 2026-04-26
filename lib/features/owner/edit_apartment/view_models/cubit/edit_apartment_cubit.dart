import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sakan/features/student/home/apartment/models/apartment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'edit_apartment_state.dart';

class EditApartmentCubit extends Cubit<EditApartmentState> {
  final SupabaseClient supabase;
  final ApartmentModel original;

  EditApartmentCubit(this.supabase, this.original) : super(EditApartmentInitial());

  Future<void> updateApartment(
    ApartmentModel updated, {
    required List<File> newImages,
    required List<String> imagesToDelete,
  }) async {
    emit(EditApartmentLoading());

    try {
      // 1. Update core apartment data
      await supabase.from('apartments').update({
        'title': updated.title,
        'description': updated.description,
        'price': updated.price,
        'lat': updated.lat,
        'lng': updated.lng,
        'is_available': updated.isAvailable,
      }).eq('id', original.id);

      // 2. Delete selected old images
      if (imagesToDelete.isNotEmpty) {
        await supabase
            .from('apartment_images')
            .delete()
            .inFilter('image_url', imagesToDelete);
      }

      // 3. Upload new images
      for (final file in newImages) {
        final fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
        final path = 'apartments/${original.id}/$fileName';

        await supabase.storage.from('apartment-images').upload(path, file);

        final publicUrl = supabase.storage.from('apartments').getPublicUrl(path);

        await supabase.from('apartment_images').insert({
          'apartment_id': original.id,
          'image_url': publicUrl,
        });
      }

      emit(EditApartmentSuccess());
    } catch (e) {
      emit(EditApartmentError('Failed to update apartment. Please check your connection and try again.'));
    }
  }
}
