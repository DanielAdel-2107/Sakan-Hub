import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/student/chat/models/chat_model.dart';
import 'package:sakan/features/student/my_bookings/models/my_booking_model.dart';
import 'package:sakan/features/student/my_bookings/view_models/cubit/my_bookings_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyBookingsCubit extends Cubit<MyBookingsState> {
  final SupabaseClient _supabase = Supabase.instance.client;

  MyBookingsCubit() : super(MyBookingsState());

  Future<void> fetchMyBookings() async {
    emit(state.copyWith(status: MyBookingsStatus.loading));
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        emit(state.copyWith(status: MyBookingsStatus.error, error: "User not logged in"));
        return;
      }

      final response = await _supabase
          .from('bookings')
          .select('*, apartments(*, apartment_images(*), profiles(*))')
          .eq('student_id', userId)
          .order('created_at', ascending: false);

      final List<dynamic> data = response as List<dynamic>;
      final List<MyBookingModel> bookings = data.map((json) => MyBookingModel.fromJson(json)).toList();

      emit(state.copyWith(
        status: MyBookingsStatus.loaded,
        bookings: bookings,
        filteredBookings: _applyFilter(bookings, state.activeFilter),
      ));
    } catch (e) {
      emit(state.copyWith(status: MyBookingsStatus.error, error: "Failed to fetch bookings: ${e.toString()}"));
    }
  }

  void updateFilter(String filter) {
    emit(state.copyWith(
      activeFilter: filter,
      filteredBookings: _applyFilter(state.bookings, filter),
    ));
  }

  List<MyBookingModel> _applyFilter(List<MyBookingModel> bookings, String filter) {
    if (filter == 'All') return bookings;
    return bookings.where((b) => b.status.toLowerCase() == filter.toLowerCase()).toList();
  }

  Future<void> openChat(MyBookingModel booking) async {
    emit(state.copyWith(status: MyBookingsStatus.chatLoading));
    try {
      final studentId = _supabase.auth.currentUser?.id;
      final ownerId = booking.apartment.ownerId;

      final existingRoom = await _supabase
          .from('chat_rooms')
          .select('id')
          .eq('student_id', studentId!)
          .eq('owner_id', ownerId)
          .maybeSingle();

      String roomId;
      if (existingRoom != null) {
        roomId = existingRoom['id'] as String;
      } else {
        final newRoomResponse = await _supabase.from('chat_rooms').insert({
          'student_id': studentId,
          'owner_id': ownerId,
          'apartment_id': booking.apartmentId,
          'created_at': DateTime.now().toUtc().toIso8601String(),
        }).select('id').single();
        roomId = newRoomResponse['id'] as String;

        await _supabase.from('messages').insert({
          'id': roomId,
          'messages': [],
          'created_at': DateTime.now().toUtc().toIso8601String(),
        });
      }

      final chatModel = ChatModel(
        roomId: roomId,
        userImage: booking.apartment.owner.imageUrl ?? '',
        userName: booking.apartment.owner.fullName,
      );

      emit(state.copyWith(status: MyBookingsStatus.chatNavigate, chatModel: chatModel));
      
      // Reset status to loaded after navigation to avoid staying in 'chatNavigate' if user returns
      emit(state.copyWith(status: MyBookingsStatus.loaded));
    } catch (e) {
      emit(state.copyWith(status: MyBookingsStatus.error, error: "Failed to open chat: ${e.toString()}"));
    }
  }
}
