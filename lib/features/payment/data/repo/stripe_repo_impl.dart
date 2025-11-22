import 'package:dartz/dartz.dart';
import 'package:suits/core/error/custom_excption.dart';

import '../../../../core/error/failure.dart';
import '../../domain/repo/stripe_repo.dart';
import '../models/payment_intent_input_model.dart';
import '../service/stripe_sevice.dart';

class StripeRepoImpl implements StripeRepo {
  final StripeSevice _stripeSevice = StripeSevice();
  @override
  Future<Either<CustomFailure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    try {
      await _stripeSevice.makePayment(
        paymentIntentinputModel: paymentIntentInputModel,
      );
      return right(null);
    } on CustomException catch (ex) {
      return Left(CustomFailure(errMessage: ex.errMessage));
    }
  }
}
