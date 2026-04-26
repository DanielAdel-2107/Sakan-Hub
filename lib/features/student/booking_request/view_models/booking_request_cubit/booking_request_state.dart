import 'package:sakan/features/student/booking_request/models/booking_request_model.dart';

abstract class BookingRequestState {}

class BookingRequestInitial extends BookingRequestState {}

class BookingRequestLoading extends BookingRequestState {}

class BookingRequestLoaded extends BookingRequestState {
  final BookingRequestModel bookingRequest;
  BookingRequestLoaded(this.bookingRequest);
}

class BookingRequestSuccess extends BookingRequestState {
  final String message;
  BookingRequestSuccess(this.message);
}

class BookingRequestError extends BookingRequestState {
  final String message;
  BookingRequestError(this.message);
}
