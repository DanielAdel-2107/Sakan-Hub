import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/di/dependancy_injection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/chat_room_model.dart';
part 'chat_rooms_state.dart';

class ChatRoomsCubit extends Cubit<ChatRoomsState> {
  ChatRoomsCubit() : super(ChatRoomsInitial());

  final _supabase = Supabase.instance.client;

  Future<void> fetchChatRooms() async {
    emit(ChatRoomsLoading());

    try {
      final userId = _supabase.auth.currentUser?.id;

      final response = await _supabase
          .from('chat_rooms')
          .select('''
            *,
            owner:profiles!chat_rooms_owner_id_fkey (
              full_name,
              image_url
            )
          ''')
          .eq('student_id', getIt<SupabaseClient>().auth.currentUser!.id)
          .order('created_at', ascending: false);

      final List<ChatRoomModel> rooms = (response as List<dynamic>)
          .map((room) => ChatRoomModel.fromMap(room as Map<String, dynamic>))
          .toList();

      emit(ChatRoomsLoaded(chatRooms: rooms));
    } catch (e) {
      emit(ChatRoomsError(message: e.toString()));
    }
  }
}