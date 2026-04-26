part of 'chat_rooms_cubit.dart';

@immutable

@immutable
sealed class ChatRoomsState {}

class ChatRoomsInitial extends ChatRoomsState {}

class ChatRoomsLoading extends ChatRoomsState {}

class ChatRoomsLoaded extends ChatRoomsState {
  final List<Map<String, dynamic>> allRooms;
  final List<Map<String, dynamic>> filteredRooms;

  ChatRoomsLoaded({
    required this.allRooms,
    required this.filteredRooms,
  });

  ChatRoomsLoaded copyWith({
    List<Map<String, dynamic>>? allRooms,
    List<Map<String, dynamic>>? filteredRooms,
  }) {
    return ChatRoomsLoaded(
      allRooms: allRooms ?? this.allRooms,
      filteredRooms: filteredRooms ?? this.filteredRooms,
    );
  }
}

class ChatRoomsEmpty extends ChatRoomsState {}

class ChatRoomsError extends ChatRoomsState {
  final String message;
  ChatRoomsError(this.message);
}