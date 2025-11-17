import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/cart_item_model.dart';

class CartService {
  final FirebaseFirestore firestore;
  final String collectionName = 'cart';

  CartService({required this.firestore});

  Future<void> addProduct(CartItemModel item) async {
    await firestore.collection(collectionName).doc(item.product.id).set(item.toMap());
  }

  Future<void> removeProduct(String productId) async {
    await firestore.collection(collectionName).doc(productId).delete();
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    await firestore.collection(collectionName).doc(productId).update({'quantity': quantity});
  }

  Future<List<CartItemModel>> getProducts() async {
    final snapshot = await firestore.collection(collectionName).get();
    return snapshot.docs.map((doc) => CartItemModel.fromMap(doc.data())).toList();
  }
}
