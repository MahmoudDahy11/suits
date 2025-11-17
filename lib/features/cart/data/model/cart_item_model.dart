import '../../../home/domain/entity/product_entity.dart';
import '../../domain/entity/cart_item_entity.dart';

class CartItemModel extends CartItemEntity {
  CartItemModel({required super.product, super.quantity = 1});

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      product: ProductEntity.fromJson(Map<String, dynamic>.from(map['product'])),
      quantity: map['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }
}
