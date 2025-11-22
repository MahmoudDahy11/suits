class OrderItemModel {
  final String name;
  final int quantity;
  final String price;
  final String currency;

  const OrderItemModel({
    required this.name,
    required this.quantity,
    required this.price,
    required this.currency,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? '0',
      currency: json['currency'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'currency': currency,
    };
  }
}
