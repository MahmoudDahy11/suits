import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/helper/show_snak_bar.dart';
import 'package:suits/core/secret/secret.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/widgets/custom_app_bar.dart';
import 'package:suits/core/widgets/custom_button.dart';
import 'package:suits/core/widgets/custom_text_field.dart';
import 'package:suits/features/payment/presentation/cubits/stripe_payment/stripe_payment_cubit.dart';

import '../../data/models/payment_intent_input_model.dart';
import '../../data/models/paypal_model/amount_details_model.dart';
import '../../data/models/paypal_model/amount_model.dart';
import '../../data/models/paypal_model/item_list_model.dart';
import '../../data/models/paypal_model/order_item_model.dart';
import 'widgets/payment_options.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  String? _selectedPaymentMethod;

  void _confirmPayment(BuildContext context) {
    if (_selectedPaymentMethod == null) {
      showSnakBar(context, 'Please select a payment method.', isError: true);
      return;
    }

    if (_selectedPaymentMethod == 'stripe') {
      final paymentIntentInputModel = PaymentIntentInputModel(
        amount: 100.2,
        currency: "USD",
        customerId: ApiKeys.customerId,
      );
      BlocProvider.of<StripePaymentCubit>(
        context,
      ).makePayment(paymentIntentInputModel: paymentIntentInputModel);
    } else if (_selectedPaymentMethod == 'paypal') {
      final transactionsData = getTransactionsData();
      excutePaypalpayment(context, transactionsData);
    } else if (_selectedPaymentMethod == 'google') {
      showSnakBar(
        context,
        'Google Pay selected. Implementation missing.',
        isError: false,
      );
    }
  }

  void excutePaypalpayment(
    BuildContext context,
    ({AmountModel amount, ItemListModel itemList}) transactionsData,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalCheckoutView(
          sandboxMode: true,
          clientId: ApiKeys.clientIdPayPal,
          secretKey: ApiKeys.secretKeyPayPal,
          transactions: [
            {
              "amount": transactionsData.amount.toJson(),
              "description": "The payment transaction description.",
              "item_list": transactionsData.itemList.toJson(),
            },
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) async {
            log("onSuccess: $params");
            showSnakBar(context, "Payment Successful");
          },
          onError: (error) {
            log("onError: $error");
            Navigator.pop(context);
            showSnakBar(context, error.toString(), isError: true);
          },
          onCancel: () {
            if (kDebugMode) {
              print('cancelled:');
            }
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  ({AmountModel amount, ItemListModel itemList}) getTransactionsData() {
    const amount = AmountModel(
      total: "100",
      currency: "USD",
      details: AmountDetailsModel(
        subtotal: "100",
        shipping: "0",
        shippingDiscount: 0,
      ),
    );
    final List<OrderItemModel> orders = [
      const OrderItemModel(
        name: "Apple",
        quantity: 4,
        price: '10',
        currency: "USD",
      ),
      const OrderItemModel(
        name: "Pineapple",
        quantity: 5,
        price: '12',
        currency: "USD",
      ),
    ];
    final itemList = ItemListModel(orders: orders);
    return (amount: amount, itemList: itemList);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StripePaymentCubit, StripePaymentState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: Scaffold(
            backgroundColor: const Color(scafoldColor),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      title: 'Payment Methods',
                      onTap: () => context.go(homeRoot),
                    ),
                    const SizedBox(height: spacebetweenSections),
                    const Text(
                      'Credit & Debit Card',
                      style: AppTextStyles.style16BoldBlack3,
                    ),
                    const SizedBox(height: spacebetweenSections),
                    CustomTextField(
                      hintText: 'Add Card',
                      prefixIcon: const Icon(
                        CupertinoIcons.creditcard,
                        color: Color(primaryColor),
                      ),
                    ),
                    const SizedBox(height: spacebetweenSections),
                    const Text(
                      'More Payment Options',
                      style: AppTextStyles.style16BoldBlack3,
                    ),
                    const SizedBox(height: spacebetweenSections),
                    PaymentOptions(
                      selectedPayment: _selectedPaymentMethod,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedPaymentMethod = newValue;
                        });
                      },
                    ),
                    const Spacer(),
                    CustomButton(
                      text: 'Confirm Payment',
                      onTap: () => _confirmPayment(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
