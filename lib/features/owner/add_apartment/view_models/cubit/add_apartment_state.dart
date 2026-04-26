class AddApartmentState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final double? latitude;
  final double? longitude;

  const AddApartmentState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.latitude,
    this.longitude,
  });

  AddApartmentState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    double? latitude,
    double? longitude,
  }) {
    return AddApartmentState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}