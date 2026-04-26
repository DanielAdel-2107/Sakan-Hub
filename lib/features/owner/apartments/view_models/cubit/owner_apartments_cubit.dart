import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/di/dependancy_injection.dart';
import 'package:sakan/features/student/home/apartment/models/apartment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'owner_apartments_state.dart';

class OwnerApartmentsCubit extends Cubit<OwnerApartmentsState> {
  final SupabaseClient supabase;

  OwnerApartmentsCubit(this.supabase) : super(const OwnerApartmentsState()) {
    loadOwnerApartments();
  }

  Future<void> loadOwnerApartments() async {
    emit(state.copyWith(status: OwnerApartmentsStatus.loading));

    try {
      final response = await supabase
          .from('apartments')
          .select('''
            id, owner_id, title, description, price, lat, lng, 
            is_available, created_at,
            apartment_images!apartment_images_apartment_id_fkey (image_url)
          ''')
          .eq('owner_id', getIt<SupabaseClient>().auth.currentUser!.id)
          .order('created_at', ascending: false);

      final apartments = response.map((json) {
        return ApartmentModel.fromJson(json);
      }).toList();

      if (apartments.isEmpty) {
        emit(state.copyWith(status: OwnerApartmentsStatus.empty, apartments: []));
      } else {
        emit(state.copyWith(status: OwnerApartmentsStatus.loaded, apartments: apartments));
      }
    } catch (e) {
      emit(state.copyWith(
        status: OwnerApartmentsStatus.error,
        errorMessage: 'Failed to load your apartments. Please check your connection.',
      ));
    }
  }

  Future<void> deleteApartment(String apartmentId) async {
    emit(state.copyWith(status: OwnerApartmentsStatus.deleting));
    try {
      await supabase.from('apartments').delete().eq('id', apartmentId);
      
      // Emit success state before reloading
      emit(state.copyWith(status: OwnerApartmentsStatus.deleteSuccess));
      
      // Reload the list
      await loadOwnerApartments();
    } catch (e) {
      emit(state.copyWith(
        status: OwnerApartmentsStatus.deleteError,
        errorMessage: 'Could not delete apartment. It might be linked to active bookings.',
      ));
    }
  }
}
