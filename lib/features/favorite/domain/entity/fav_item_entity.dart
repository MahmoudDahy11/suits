import 'package:equatable/equatable.dart';
import '../../../home/domain/entity/product_entity.dart';

class FavoriteItemEntity extends Equatable {
  final ProductEntity product;

  const FavoriteItemEntity({required this.product});
  
  @override
  List<Object?> get props => [product]; 
}