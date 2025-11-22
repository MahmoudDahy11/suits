import 'package:dartz/dartz.dart';
import 'package:suits/core/error/failure.dart';

import '../../data/models/payment_intent_input_model.dart';

abstract class StripeRepo {
  Future<Either<CustomFailure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  });
}
