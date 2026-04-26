import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/student/home/apartment_details/models/booking_model.dart';
import 'package:sakan/features/student/home/apartment_details/view_models/cubit/booking_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookingCubit extends Cubit<BookingState> {
  final SupabaseClient _supabase = Supabase.instance.client;

  BookingCubit() : super(BookingInitial());

  Future<void> submitBooking(BookingModel booking) async {
    if (state is BookingLoading) return;

    try {
      emit(BookingLoading());
      final existingBooking = await _supabase
          .from('bookings')
          .select()
          .eq('apartment_id', booking.apartmentId)
          .eq('student_id', booking.studentId)
          .maybeSingle(); // سنحصل على نتيجة واحدة أو لا شيء

      if (existingBooking != null) {
        // إذا وجد حجز مسبق، نطلق حالة "موجود مسبقاً"
        emit(BookingAlreadyExists());
        return;
      }

      // 2. إذا لم يوجد، نقوم بإضافة الحجز الجديد
      final response = await _supabase
          .from('bookings')
          .insert(booking.toMap())
          .select('id')
          .single();
      final String bookingId = response['id'] as String;
      emit(BookingSuccess(bookingId: bookingId));
    } on PostgrestException catch (e) {
      emit(BookingError("خطأ في قاعدة البيانات: ${e.message}"));
    } catch (e) {
      emit(BookingError("حدث خطأ غير متوقع: ${e.toString()}"));
    }
  }

  Future<void> startOrOpenChat({
    required String studentId,
    required String ownerId,
    required String ownerName,
    String? ownerImage,
    String? apartmentId,
    String? initialMessage,
  }) async {
    if (state is ChatLoading) return;

    emit(ChatLoading());

    try {
      // 1. البحث عن غرفة موجودة
      final existingRoom = await _supabase
          .from('chat_rooms')
          .select('id')
          .eq('student_id', studentId)
          .eq('owner_id', ownerId)
          // .eq('apartment_id', apartmentId)   // ← فعّلها لو عايز تربط بالشقة دايماً
          .maybeSingle();

      String roomId;

      if (existingRoom != null && existingRoom['id'] != null) {
        roomId = existingRoom['id'] as String;
      } else {
        // 2. إنشاء غرفة جديدة
        final newRoomData = {
          'student_id': studentId,
          'owner_id': ownerId,
          'apartment_id': ?apartmentId,
          'created_at': DateTime.now().toUtc().toIso8601String(),
        };

        final insertResult = await _supabase
            .from('chat_rooms')
            .insert(newRoomData)
            .select('id')
            .single();

        roomId = insertResult['id'] as String;

        await _supabase.from('messages').insert({
          'id': roomId,
          'messages': [],
          'created_at': DateTime.now().toUtc().toIso8601String(),
        });
      }

      // نجاح → نطلّع الـ roomId مع بيانات الطرف الآخر
      emit(
        ChatSuccess(
          roomId: roomId,
          otherUserId: ownerId,
          otherUserName: ownerName,
          otherUserImage: ownerImage,
        ),
      );
    } on PostgrestException catch (e) {
      emit(ChatError("خطأ في الاتصال بقاعدة البيانات: ${e.message}"));
    } catch (e) {
      emit(ChatError("حدث خطأ غير متوقع: $e"));
    }
  }
}
