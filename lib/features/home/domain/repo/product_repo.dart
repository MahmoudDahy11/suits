import 'package:dartz/dartz.dart';
import 'package:suits/core/error/failure.dart';
import 'package:suits/features/home/domain/entity/product_entity.dart';

abstract class ProductRepo {
  Future<Either<CustomFailure, List<ProductEntity>>> get({
    required String endPoint,
    String? token,
   Map<String, dynamic>? queryParameters,
  });
}
