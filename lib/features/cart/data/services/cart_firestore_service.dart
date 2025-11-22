import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/cart_item_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartService {
  final FirebaseFirestore firestore;

  CartService({required this.firestore});

  CollectionReference<Map<String, dynamic>> get _userCart {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception('User must be authenticated to access cart.');
    }
    return firestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('cart');
  }

  Future<void> addProduct(CartItemModel item) async {
    await _userCart.doc(item.product.id).set(item.toMap());
  }

  Future<void> removeProduct(String productId) async {
    await _userCart.doc(productId).delete();
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    await _userCart.doc(productId).update({'quantity': quantity});
  }

  Future<List<CartItemModel>> getProducts() async {
    final snapshot = await _userCart.get();
    return snapshot.docs
        .map((doc) => CartItemModel.fromMap(doc.data()))
        .toList();
  }

  Future<void> clearCart() async {
    final snapshot = await _userCart.get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
