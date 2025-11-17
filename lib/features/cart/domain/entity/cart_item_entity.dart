import 'package:suits/features/home/domain/entity/product_entity.dart';

class CartItemEntity {
  final ProductEntity product;
  final int quantity;

  CartItemEntity({required this.product, this.quantity = 1});
}
