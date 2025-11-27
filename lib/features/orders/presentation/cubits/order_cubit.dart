import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entity/order_entity.dart';
import '../../domain/repo/order_repo.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepo repo;

  OrderCubit(this.repo) : super(OrderInitial());

  Future<void> addOrder(OrderEntity order) async {
    emit(OrderLoading());
    final result = await repo.addOrder(order);
    if (isClosed) return;
    result.fold(
      (failure) => emit(OrderFailure(failure.errMessage)),
      (_) => emit(OrderSuccess()),
    );
  }

  Future<void> getOrders() async {
    emit(OrderLoading());
    final result = await repo.getOrders();
    if (isClosed) return;
    result.fold(
      (failure) => emit(OrderFailure(failure.errMessage)),
      (orders) => emit(OrderLoaded(orders)),
    );
  }
}
