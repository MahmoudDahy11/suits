part of 'favorite_cubit.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<FavoriteItemEntity> items;
  const FavoriteLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class FavoriteFailure extends FavoriteState {
  final String error;
  const FavoriteFailure(this.error);

  @override
  List<Object> get props => [error];
}
