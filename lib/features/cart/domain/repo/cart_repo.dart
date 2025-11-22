import '../entity/cart_item_entity.dart';

abstract class CartRepository {
  Future<void> addProduct(CartItemEntity item);
  Future<void> removeProduct(String productId);
  Future<List<CartItemEntity>> getCartProducts();
  Future<void> increaseQuantity(String productId);
  Future<void> decreaseQuantity(String productId);
  Future<void> clearCart();
}
