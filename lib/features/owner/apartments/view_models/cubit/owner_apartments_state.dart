part of 'owner_apartments_cubit.dart';

enum OwnerApartmentsStatus {
  initial,
  loading,
  loaded,
  empty,
  error,
  deleting,
  deleteSuccess,
  deleteError
}

class OwnerApartmentsState {
  final List<ApartmentModel> apartments;
  final OwnerApartmentsStatus status;
  final String? errorMessage;

  const OwnerApartmentsState({
    this.apartments = const [],
    this.status = OwnerApartmentsStatus.initial,
    this.errorMessage,
  });

  OwnerApartmentsState copyWith({
    List<ApartmentModel>? apartments,
    OwnerApartmentsStatus? status,
    String? errorMessage,
  }) {
    return OwnerApartmentsState(
      apartments: apartments ?? this.apartments,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
