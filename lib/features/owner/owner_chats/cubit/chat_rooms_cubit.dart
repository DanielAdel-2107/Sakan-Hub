import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sakan/core/di/dependancy_injection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'chat_rooms_state.dart';

class ChatRoomsCubit extends Cubit<ChatRoomsState> {
  final supabase = Supabase.instance.client;

  ChatRoomsCubit() : super(ChatRoomsInitial());

  Future<void> fetchChatRooms() async {
    emit(ChatRoomsLoading());

    try {
      final currentUserId = getIt<SupabaseClient>().auth.currentUser?.id;
      final response = await supabase
          .from('chat_rooms')
          .select('''
            id, 
            student_id, 
            apartment_id, 
            created_at,
            profiles!student_id (full_name, image_url),
            apartments!apartment_id (title)
          ''')
          .eq('owner_id', currentUserId!)
          .order('created_at', ascending: false);
      log(response.toString());
      final rooms = List<Map<String, dynamic>>.from(response);

      if (rooms.isEmpty) {
        emit(ChatRoomsEmpty());
      } else {
        emit(ChatRoomsLoaded(
          allRooms: rooms,
          filteredRooms: rooms,
        ));
      }
    } catch (e) {
      log('Error fetching chat rooms: $e');
      emit(ChatRoomsError('حدث خطأ أثناء جلب المحادثات'));
    }
  }

  void filterRooms(String query) {
    if (state is! ChatRoomsLoaded) return;

    final currentState = state as ChatRoomsLoaded;
    final trimmedQuery = query.trim().toLowerCase();

    if (trimmedQuery.isEmpty) {
      emit(currentState.copyWith(filteredRooms: currentState.allRooms));
      return;
    }

    final filtered = currentState.allRooms.where((room) {
      final student = room['profiles!student_id'] as Map? ?? {};
      final apartment = room['apartments!apartment_id'] as Map? ?? {};

      final studentName = (student['full_name'] as String?)?.toLowerCase() ?? '';
      final aptTitle = (apartment['title'] as String?)?.toLowerCase() ?? '';

      return studentName.contains(trimmedQuery) || aptTitle.contains(trimmedQuery);
    }).toList();

    emit(currentState.copyWith(filteredRooms: filtered));
  }
}