import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/fav_item_model.dart';

class FavoriteService {
  final FirebaseFirestore firestore;

  FavoriteService({required this.firestore});

  CollectionReference<Map<String, dynamic>> get _userFavorites {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception('User must be authenticated to access favorites.');
    }
    return firestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('favorites');
  }

  Future<void> addFavorite(FavoriteItemModel item) async {
    await _userFavorites.doc(item.product.id).set(item.toMap());
  }

  Future<void> removeFavorite(String productId) async {
    await _userFavorites.doc(productId).delete();
  }

  Future<List<FavoriteItemModel>> getFavorites() async {
    final snapshot = await _userFavorites.get();
    return snapshot.docs
        .map((doc) => FavoriteItemModel.fromMap(doc.data()))
        .toList();
  }

  Future<bool> isFavorite(String productId) async {
    final doc = await _userFavorites.doc(productId).get();
    return doc.exists;
  }
}
