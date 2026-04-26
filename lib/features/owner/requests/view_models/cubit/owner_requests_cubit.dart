import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sakan/core/di/dependancy_injection.dart';
import 'package:sakan/features/owner/requests/models/owner_request_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'owner_requests_state.dart';

class OwnerRequestsCubit extends Cubit<OwnerRequestsState> {
  OwnerRequestsCubit() : super(OwnerRequestsInitial());

  String _currentFilter = 'All';
  String get currentFilter => _currentFilter;

  void changeFilter(String filter) {
    if (_currentFilter != filter) {
      _currentFilter = filter;
      if (state is OwnerRequestsLoaded) {
        emit(OwnerRequestsLoaded((state as OwnerRequestsLoaded).items));
      }
    }
  }

  final _supabase = Supabase.instance.client;

  Future<void> loadRequests() async {
    emit(OwnerRequestsLoading());

    try {
      final response = await _supabase.rpc(
        'get_owner_requested_apartments',
        params: {'p_owner_id': getIt<SupabaseClient>().auth.currentUser!.id},
      );

      final items = (response as List<dynamic>)
          .map((e) => OwnerRequestItem.fromJson(e as Map<String, dynamic>))
          .toList();

      emit(OwnerRequestsLoaded(items));
    } catch (e, st) {
      emit(OwnerRequestsError('Failed to load: $e'));
      debugPrint('$e\n$st');
    }
  }

  Future<void> changeStatus(String bookingId, String newStatus) async {
    try {
      await _supabase
          .from('bookings')
          .update({'status': newStatus})
          .eq('id', bookingId);

      if (newStatus == 'approved') {
        final booking = await _supabase
            .from('bookings')
            .select('apartment_id')
            .eq('id', bookingId)
            .single();

        await _supabase
            .from('apartments')
            .update({'is_available': false})
            .eq('id', booking['apartment_id']);
      }

      await loadRequests();
    } catch (e) {
      debugPrint('Status change failed: $e');
    }
  }
}
