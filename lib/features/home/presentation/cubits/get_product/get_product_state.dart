part of 'get_product_cubit.dart';

sealed class GetProductState extends Equatable {
  const GetProductState();

  @override
  List<Object> get props => [];
}

final class GetProductInitial extends GetProductState {}

final class GetProductLoading extends GetProductState {}

final class GetProductFailure extends GetProductState {
  final String errMessage;
  const GetProductFailure({required this.errMessage});
  @override
  List<Object> get props => [errMessage];
}

final class GetProductSuccess extends GetProductState {
  final List<ProductEntity> products;
  const GetProductSuccess({required this.products});
  @override
  List<Object> get props => [products];
}
