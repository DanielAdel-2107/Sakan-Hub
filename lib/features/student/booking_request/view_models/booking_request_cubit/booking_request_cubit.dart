import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/student/booking_request/models/booking_request_model.dart';
import 'package:sakan/features/student/booking_request/view_models/booking_request_cubit/booking_request_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookingRequestCubit extends Cubit<BookingRequestState> {
  final SupabaseClient _supabase = Supabase.instance.client;

  BookingRequestCubit() : super(BookingRequestInitial());

  Future<void> loadBookingRequest(String bookingId) async {
    emit(BookingRequestLoading());
    try {
      final response = await _supabase
          .from('bookings')
          .select('*, apartments(*, apartment_images(*), profiles(*))')
          .eq('id', bookingId)
          .single();

      final booking = BookingRequestModel.fromJson(response);
      emit(BookingRequestLoaded(booking));
    } catch (e) {
      emit(BookingRequestError("Failed to load booking: ${e.toString()}"));
    }
  }

  Future<void> confirmBooking(String bookingId) async {
    emit(BookingRequestLoading());
    try {
      await _supabase
          .from('bookings')
          .update({'status': 'pending'}) // Status is set to pending by user confirmation if needed
          .eq('id', bookingId);
      
      emit(BookingRequestSuccess("Booking request submitted for approval!"));
      // Reload to reflect changes
      await loadBookingRequest(bookingId);
    } catch (e) {
      emit(BookingRequestError("Failed to confirm booking: ${e.toString()}"));
    }
  }
}
