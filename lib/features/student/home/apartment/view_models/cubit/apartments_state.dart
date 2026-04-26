import 'package:sakan/features/student/home/apartment/models/apartment_model.dart';

abstract class ApartmentsState {}

class ApartmentsInitial extends ApartmentsState {}

class ApartmentsLoading extends ApartmentsState {}

class ApartmentsSuccess extends ApartmentsState {
  final List<ApartmentModel> apartments;
  final List<ApartmentModel> allApartments;
  final DateTime? timestamp;
  ApartmentsSuccess({
    required this.apartments,
    required this.allApartments,
    this.timestamp,
  });
}

class ApartmentsError extends ApartmentsState {
  final String message;
  ApartmentsError(this.message);
}
