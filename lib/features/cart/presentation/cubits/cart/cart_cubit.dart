import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entity/cart_item_entity.dart';
import '../../../domain/repo/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository repository;

  CartCubit({required this.repository}) : super(CartInitial());

  Future<void> loadCart() async {
    emit(CartLoading());
    final items = await repository.getCartProducts();
    emit(CartLoaded(items));
  }

  Future<void> addProduct(CartItemEntity item) async {
    await repository.addProduct(item);
    await loadCart();
  }

  Future<void> removeProduct(String productId) async {
    await repository.removeProduct(productId);
    await loadCart();
  }

  Future<void> increaseQuantity(String productId) async {
    await repository.increaseQuantity(productId);
    await loadCart();
  }

  Future<void> decreaseQuantity(String productId) async {
    await repository.decreaseQuantity(productId);
    await loadCart();
  }
}
