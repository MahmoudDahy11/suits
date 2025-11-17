import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/fav_item_model.dart';

class FavoriteService {
  final FirebaseFirestore firestore;
  final String collectionName = 'favorites';

  FavoriteService({required this.firestore});

  Future<void> addFavorite(FavoriteItemModel item) async {
    await firestore.collection(collectionName).doc(item.product.id).set(item.toMap());
  }

  Future<void> removeFavorite(String productId) async {
    await firestore.collection(collectionName).doc(productId).delete();
  }

  Future<List<FavoriteItemModel>> getFavorites() async {
    final snapshot = await firestore.collection(collectionName).get();
    return snapshot.docs.map((doc) => FavoriteItemModel.fromMap(doc.data())).toList();
  }

  Future<bool> isFavorite(String productId) async {
    final doc = await firestore.collection(collectionName).doc(productId).get();
    return doc.exists;
  }
}
