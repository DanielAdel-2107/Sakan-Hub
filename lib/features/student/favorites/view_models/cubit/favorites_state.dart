enum FavoritesStatus { initial, loading, success, error }

class FavoritesState {
  final List<String> favoriteIds;
  final FavoritesStatus status;
  final String? errorMessage;

  FavoritesState({
    this.favoriteIds = const [],
    this.status = FavoritesStatus.initial,
    this.errorMessage,
  });

  FavoritesState copyWith({
    List<String>? favoriteIds,
    FavoritesStatus? status,
    String? errorMessage,
  }) {
    return FavoritesState(
      favoriteIds: favoriteIds ?? this.favoriteIds,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
