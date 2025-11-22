import 'package:suits/core/secret/secret.dart';

class InitPaymentSheetInputModel {
  final String paymentIntentClientSecret;
  final String ephemeralKeySecret;
  final String customerId = ApiKeys.customerId;

  InitPaymentSheetInputModel({
    required this.paymentIntentClientSecret,
    required this.ephemeralKeySecret,
  });
}
