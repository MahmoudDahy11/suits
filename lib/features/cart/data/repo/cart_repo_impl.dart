import '../../domain/entity/cart_item_entity.dart';
import '../../domain/repo/cart_repo.dart';
import '../model/cart_item_model.dart';
import '../services/cart_firestore_service.dart';

class CartRepositoryImpl implements CartRepository {
  final CartService service;

  CartRepositoryImpl({required this.service});

  @override
  Future<void> addProduct(CartItemEntity item) async {
    await service.addProduct(
      CartItemModel(product: item.product, quantity: item.quantity),
    );
  }

  @override
  Future<void> removeProduct(String productId) async {
    await service.removeProduct(productId);
  }

  @override
  Future<void> increaseQuantity(String productId) async {
    final products = await service.getProducts();
    final item = products.firstWhere((e) => e.product.id == productId);
    await service.updateQuantity(productId, item.quantity + 1);
  }

  @override
  Future<void> decreaseQuantity(String productId) async {
    final products = await service.getProducts();
    final item = products.firstWhere((e) => e.product.id == productId);
    if (item.quantity > 1) {
      await service.updateQuantity(productId, item.quantity - 1);
    }
  }

  @override
  Future<List<CartItemEntity>> getCartProducts() async {
    final items = await service.getProducts();
    return items;
  }

  @override
  Future<void> clearCart() async {
    await service.clearCart();
  }
}
