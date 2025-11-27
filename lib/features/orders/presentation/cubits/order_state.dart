part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {}

class OrderFailure extends OrderState {
  final String message;

  OrderFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class OrderLoaded extends OrderState {
  final List<OrderEntity> orders;

  OrderLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}
