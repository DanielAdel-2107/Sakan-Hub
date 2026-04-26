import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/student/favorites/view_models/cubit/favorites_state.dart';
import 'package:sakan/features/student/home/apartment/service/favorite_service.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesState());

  Future<void> fetchFavorites() async {
    emit(state.copyWith(status: FavoritesStatus.loading));
    try {
      final favorites = await FavoriteService.getFavorites();
      emit(state.copyWith(
        favoriteIds: favorites,
        status: FavoritesStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FavoritesStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> toggleFavorite(String id) async {
    // Optimistic Update
    final currentIds = List<String>.from(state.favoriteIds);
    final bool isCurrentlyFavorite = currentIds.contains(id);
    
    if (isCurrentlyFavorite) {
      currentIds.remove(id);
    } else {
      currentIds.add(id);
    }
    
    emit(state.copyWith(favoriteIds: currentIds));

    try {
      await FavoriteService.toggleFavorite(id);
      // We don't need to do anything else because optimistic update already happened
      // and FavoriteService already updated SharedPreferences.
    } catch (e) {
      // Revert on error
      fetchFavorites();
    }
  }
}
