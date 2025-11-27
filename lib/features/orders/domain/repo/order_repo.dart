import 'package:dartz/dartz.dart';
import 'package:suits/core/error/failure.dart';
import '../entity/order_entity.dart';

abstract class OrderRepo {
  Future<Either<CustomFailure, void>> addOrder(OrderEntity order);
  Future<Either<CustomFailure, List<OrderEntity>>> getOrders();
}
