import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.productId,
    required super.productName,
    required super.imageUrl,
    required super.date,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      id: data['id'] ?? doc.id,
      productId: data['productId'],
      productName: data['productName'],
      imageUrl: data['imageUrl'],
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'imageUrl': imageUrl,
      'date': Timestamp.fromDate(date),
    };
  }
}
