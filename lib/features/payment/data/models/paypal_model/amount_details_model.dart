class AmountDetailsModel {
  final String subtotal;
  final String shipping;
  final num shippingDiscount;

  const AmountDetailsModel({
    required this.subtotal,
    required this.shipping,
    required this.shippingDiscount,
  });

  factory AmountDetailsModel.fromJson(Map<String, dynamic> json) {
    return AmountDetailsModel(
      subtotal: json['subtotal'] ?? '0',
      shipping: json['shipping'] ?? '0',
      shippingDiscount: json['shipping_discount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subtotal': subtotal,
      'shipping': shipping,
      'shipping_discount': shippingDiscount,
    };
  }
}
