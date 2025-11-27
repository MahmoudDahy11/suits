import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String id;
  final String productId;
  final String productName;
  final String imageUrl;
  final DateTime date;

  const OrderEntity({
    required this.id,
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.date,
  });

  @override
  List<Object?> get props => [id, productId, productName, imageUrl, date];
}
