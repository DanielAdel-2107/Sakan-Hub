import 'dart:async';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/di/dependancy_injection.dart';
import 'package:sakan/core/network/stream_data_with_spacific.dart';
import 'package:sakan/features/student/chat/models/message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.id}) : super(ChatLoading()) {
    _loadMessages();
    log(id);
  }
  final String id;
  StreamSubscription? _streamSubscription;
  final supabase = getIt<SupabaseClient>();
  final messageController = TextEditingController();

  void _loadMessages() {
    _streamSubscription =
        streamDataWithSpecificId(
          tableName: "messages",
          id: id,
          primaryKey: 'id',
        ).listen((data) {
          final dynamic messagesData = data[0]['messages'];
          final List<dynamic> messagesJson = (messagesData is List)
              ? messagesData
              : [];
          final List<ChatMessage> messages = messagesJson
              .map((json) => ChatMessage.fromJson(json))
              .toList();
          emit(ChatLoaded(messages: messages));
        });
  }

  Future<void> addMessage({required String text}) async {
    if (messageController.text.isNotEmpty) {
      try {
        final chatData = await supabase
            .from("messages")
            .select("messages")
            .eq("id", id)
            .single();
        final dynamic messagesData = chatData['messages'];
        final List<dynamic> messagesJson = (messagesData is List)
            ? messagesData
            : [];
        final List<ChatMessage> messages = messagesJson
            .map((json) => ChatMessage.fromJson(json))
            .toList();
        final newMessage = ChatMessage(
          message: text,
          id: supabase.auth.currentUser!.id,
        );
        messages.add(newMessage);
        await supabase
            .from("messages")
            .update({"messages": messages.map((m) => m.toJson()).toList()})
            .eq("id", id);
        messageController.clear();
        emit(ChatLoaded(messages: messages));
      } catch (e) {
        log(e.toString());
        emit(ChatFailed(error: e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
