import 'package:dartz/dartz.dart';
import 'package:suits/core/api/api_service.dart';
import 'package:suits/core/error/failure.dart';
import 'package:suits/features/home/domain/entity/product_entity.dart';
import 'package:suits/features/home/domain/repo/product_repo.dart';

import '../models/product_model.dart';
class ProductRepoImpl implements ProductRepo {
  ProductRepoImpl(this._apiService);
  final ApiService _apiService;

  @override
  Future<Either<CustomFailure, List<ProductEntity>>> get({
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final data = await _apiService.get(
        endPoint: endPoint,
        token: token,
        queryParameters: queryParameters,
      );

      final List<dynamic> productsJson = data['results'] ?? [];

      final List<ProductEntity> products = productsJson.map((item) {
        final model = ProductModel.fromJson(item);
        return model.toEntity();
      }).toList();

      return Right(products);
    } on CustomFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(CustomFailure(errMessage: e.toString()));
    }
  }
}
