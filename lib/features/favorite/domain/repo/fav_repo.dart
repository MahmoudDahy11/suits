import '../entity/fav_item_entity.dart';

abstract class FavoriteRepository {
  Future<void> addFavorite(FavoriteItemEntity item);
  Future<void> removeFavorite(String productId);
  Future<List<FavoriteItemEntity>> getFavorites();
  Future<bool> isFavorite(String productId);
}
