

import '../../domain/entity/fav_item_entity.dart';
import '../../domain/repo/fav_repo.dart';
import '../models/fav_item_model.dart';
import '../service/fav_service.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteService service;

  FavoriteRepositoryImpl({required this.service});

  @override
  Future<void> addFavorite(FavoriteItemEntity item) async {
    await service.addFavorite(FavoriteItemModel(product: item.product));
  }

  @override
  Future<void> removeFavorite(String productId) async {
    await service.removeFavorite(productId);
  }

  @override
  Future<List<FavoriteItemEntity>> getFavorites() async {
    final items = await service.getFavorites();
    return items;
  }

  @override
  Future<bool> isFavorite(String productId) async {
    return await service.isFavorite(productId);
  }
}
