// الحالات (States)
abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingSuccess extends BookingState {
  final String? bookingId;
  BookingSuccess({this.bookingId});
}

class BookingError extends BookingState {
  final String message;
  BookingError(this.message);
}

class BookingAlreadyExists extends BookingState {}

class ChatLoading extends BookingState {}

class ChatSuccess extends BookingState {
  final String roomId;
  final String otherUserId;
  final String otherUserName;
  final String? otherUserImage;

  ChatSuccess({
    required this.roomId,
    required this.otherUserId,
    required this.otherUserName,
    this.otherUserImage,
  });
}

class ChatError extends BookingState {
  final String message;
  ChatError(this.message);
}