import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import '../../../domain/entity/fav_item_entity.dart';
import '../../../domain/repo/fav_repo.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepository repository;

  FavoriteCubit({required this.repository}) : super(FavoriteInitial());

  Future<void> loadFavorites() async {
    emit(FavoriteLoading());
    final items = await repository.getFavorites();
    emit(FavoriteLoaded(items));
  }

  Future<void> toggleFavorite(FavoriteItemEntity item) async {
    final isFav = await repository.isFavorite(item.product.id);
    if (isFav) {
      await repository.removeFavorite(item.product.id);
    } else {
      await repository.addFavorite(item);
    }
    await loadFavorites();
  }
}
