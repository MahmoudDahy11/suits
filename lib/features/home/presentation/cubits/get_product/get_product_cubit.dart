import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:suits/features/home/domain/repo/product_repo.dart';

import '../../../domain/entity/product_entity.dart';

part 'get_product_state.dart';

class GetProductCubit extends Cubit<GetProductState> {
  GetProductCubit(this._productRepo) : super(GetProductInitial());
  final ProductRepo _productRepo;
  Future<void> getProducts({
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    if (isClosed) return;
    emit(GetProductLoading());

    final result = await _productRepo.get(
      endPoint: '/search/photos',
      token: token,
      queryParameters: queryParameters,
    );

    if (isClosed) return;

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(GetProductFailure(errMessage: failure.errMessage));
      },
      (products) {
        if (isClosed) return;
        emit(GetProductSuccess(products: products));
      },
    );
  }
}
