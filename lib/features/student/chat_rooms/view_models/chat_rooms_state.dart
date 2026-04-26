part of 'chat_rooms_cubit.dart';

abstract class ChatRoomsState {}

class ChatRoomsInitial extends ChatRoomsState {}

class ChatRoomsLoading extends ChatRoomsState {}

class ChatRoomsLoaded extends ChatRoomsState {
  final List<ChatRoomModel> chatRooms;
  ChatRoomsLoaded({required this.chatRooms});
}

class ChatRoomsError extends ChatRoomsState {
  final String message;
  ChatRoomsError({required this.message});
}