import 'order_item_model.dart';

class ItemListModel {
  final List<OrderItemModel> orders;

  const ItemListModel({required this.orders});

  factory ItemListModel.fromJson(Map<String, dynamic> json) {
    return ItemListModel(
      orders: (json['items'] as List<dynamic>? ?? [])
          .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'items': orders.map((e) => e.toJson()).toList()};
  }
}
