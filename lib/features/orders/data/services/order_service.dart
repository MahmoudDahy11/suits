import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/order_model.dart';

class OrderService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth = FirebaseAuth.instance;

  OrderService({required this.firestore});

  Future<void> addOrder(OrderModel order) async {
    final userId = auth.currentUser!.uid;
    await firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(order.id)
        .set(order.toJson());
  }

  Future<List<OrderModel>> getOrders() async {
    final userId = auth.currentUser!.uid;
    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .orderBy('date', descending: true)
        .get();

    return snapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList();
  }
}
