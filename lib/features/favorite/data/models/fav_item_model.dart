
import '../../../home/domain/entity/product_entity.dart';
import '../../domain/entity/fav_item_entity.dart';

class FavoriteItemModel extends FavoriteItemEntity {
  FavoriteItemModel({required super.product});

  factory FavoriteItemModel.fromMap(Map<String, dynamic> map) {
    return FavoriteItemModel(
      product: ProductEntity.fromJson(Map<String, dynamic>.from(map['product'])),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product.toJson(),
    };
  }
}
