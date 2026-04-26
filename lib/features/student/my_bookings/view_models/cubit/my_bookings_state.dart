import 'package:sakan/features/student/chat/models/chat_model.dart';
import 'package:sakan/features/student/my_bookings/models/my_booking_model.dart';

enum MyBookingsStatus { initial, loading, loaded, error, chatLoading, chatNavigate }

class MyBookingsState {
  final List<MyBookingModel> bookings;
  final List<MyBookingModel> filteredBookings;
  final String? error;
  final MyBookingsStatus status;
  final ChatModel? chatModel;
  final String activeFilter;

  MyBookingsState({
    this.bookings = const [],
    this.filteredBookings = const [],
    this.error,
    this.status = MyBookingsStatus.initial,
    this.chatModel,
    this.activeFilter = 'All',
  });

  MyBookingsState copyWith({
    List<MyBookingModel>? bookings,
    List<MyBookingModel>? filteredBookings,
    String? error,
    MyBookingsStatus? status,
    ChatModel? chatModel,
    String? activeFilter,
  }) {
    return MyBookingsState(
      bookings: bookings ?? this.bookings,
      filteredBookings: filteredBookings ?? this.filteredBookings,
      error: error ?? this.error,
      status: status ?? this.status,
      chatModel: chatModel ?? this.chatModel,
      activeFilter: activeFilter ?? this.activeFilter,
    );
  }
}
