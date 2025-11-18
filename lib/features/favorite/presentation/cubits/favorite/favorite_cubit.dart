import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entity/fav_item_entity.dart';
import '../../../domain/repo/fav_repo.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepository repository;

  FavoriteCubit({required this.repository}) : super(FavoriteInitial());

  Future<void> loadFavorites() async {
    try {
      if (state is! FavoriteLoaded) {
        if (isClosed) return;
        emit(FavoriteLoading());
      }

      final items = await repository.getFavorites();

      if (isClosed) return;
      emit(FavoriteLoaded(items));
    } catch (e) {
      if (isClosed) return;
      emit(FavoriteFailure(e.toString()));
    }
  }

  Future<void> toggleFavorite(FavoriteItemEntity item) async {
    if (state is FavoriteLoaded) {
      final currentState = state as FavoriteLoaded;
      final exists = currentState.items.any(
        (i) => i.product.id == item.product.id,
      );

      final updatedItems = exists
          ? currentState.items
                .where((i) => i.product.id != item.product.id)
                .toList()
          : [...currentState.items, item];

      if (isClosed) return;
      emit(FavoriteLoaded(updatedItems));

      try {
        if (exists) {
          await repository.removeFavorite(item.product.id);
        } else {
          await repository.addFavorite(item);
        }
      } catch (e) {
        if (isClosed) return;
        emit(FavoriteFailure(e.toString()));
        loadFavorites();
      }
    }
  }

  bool isFavorite(String productId) {
    if (state is FavoriteLoaded) {
      return (state as FavoriteLoaded).items.any(
        (i) => i.product.id == productId,
      );
    }
    return false;
  }
}
