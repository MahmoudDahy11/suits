import 'amount_details_model.dart';

class AmountModel {
  final String total;
  final String currency;
  final AmountDetailsModel details;

  const AmountModel({
    required this.total,
    required this.currency,
    required this.details,
  });

  factory AmountModel.fromJson(Map<String, dynamic> json) {
    return AmountModel(
      total: json['total'] ?? '0',
      currency: json['currency'] ?? '',
      details: AmountDetailsModel.fromJson(json['details'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'total': total, 'currency': currency, 'details': details.toJson()};
  }
}
