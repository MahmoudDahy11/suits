import 'package:dartz/dartz.dart';
import '../../domain/entity/order_entity.dart';
import '../../domain/repo/order_repo.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';
import 'package:suits/core/error/failure.dart';

class OrderRepoImpl implements OrderRepo {
  final OrderService service;

  OrderRepoImpl({required this.service});

  @override
  Future<Either<CustomFailure, void>> addOrder(OrderEntity order) async {
    try {
      final orderModel = OrderModel(
        id: order.id,
        productId: order.productId,
        productName: order.productName,
        imageUrl: order.imageUrl,
        date: order.date,
      );
      await service.addOrder(orderModel);
      return const Right(null);
    } catch (e) {
      return Left(CustomFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<CustomFailure, List<OrderEntity>>> getOrders() async {
    try {
      final orders = await service.getOrders();
      return Right(orders);
    } catch (e) {
      return Left(CustomFailure(errMessage: e.toString()));
    }
  }
}
