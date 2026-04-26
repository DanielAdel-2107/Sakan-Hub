part of 'edit_apartment_cubit.dart';

@immutable
sealed class EditApartmentState {}

class EditApartmentInitial extends EditApartmentState {}

class EditApartmentLoading extends EditApartmentState {}

class EditApartmentSuccess extends EditApartmentState {}

class EditApartmentError extends EditApartmentState {
  final String message;
  EditApartmentError(this.message);
}
