import 'dart:developer';
import 'package:flutter/cupertino.dart';
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
import 'package:suits/features/cart/presentation/cubits/cart/cart_cubit.dart';
import 'package:suits/features/location/presentation/cubits/location/location_cubit.dart';
import 'package:suits/features/payment/presentation/cubits/stripe_payment/stripe_payment_cubit.dart';
import 'package:suits/features/orders/presentation/cubits/order_cubit.dart';
import 'package:suits/features/orders/domain/entity/order_entity.dart';
import 'package:suits/core/service/notification_service.dart';
import 'package:suits/core/service/get_it.dart';

import '../../data/models/payment_intent_input_model.dart';
import '../../data/models/paypal_model/amount_details_model.dart';
import '../../data/models/paypal_model/amount_model.dart';
import '../../data/models/paypal_model/item_list_model.dart';
import '../../data/models/paypal_model/order_item_model.dart';
import 'package:suits/features/cart/presentation/views/widgets/checkout_summary.dart';
import 'widgets/payment_options.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key, required this.checkoutSummary});
  final CheckoutSummary checkoutSummary;

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  void initState() {
    super.initState();
    context.read<LocationCubit>().getLocations();
  }

  final ValueNotifier<String?> _selectedPaymentMethodNotifier = ValueNotifier(
    null,
  );

  void _confirmPayment(BuildContext context) {
    if (_selectedPaymentMethodNotifier.value == null) {
      showSnakBar(context, 'Please select a payment method.', isError: true);
      return;
    }

    if (_selectedPaymentMethodNotifier.value == 'stripe') {
      final paymentIntentInputModel = PaymentIntentInputModel(
        amount: widget.checkoutSummary.totalCost,
        currency: "USD",
        customerId: ApiKeys.customerId,
      );

      context.read<StripePaymentCubit>().makePayment(
        paymentIntentInputModel: paymentIntentInputModel,
      );
    } else if (_selectedPaymentMethodNotifier.value == 'paypal') {
      final transactionsData = getTransactionsData();
      excutePaypalpayment(context, transactionsData);
    } else if (_selectedPaymentMethodNotifier.value == 'google') {
      showSnakBar(context, 'Google Pay selected. Implementation missing.');
    }
  }

  void _navigateAfterPayment(BuildContext context) async {
    final locationState = context.read<LocationCubit>().state;

    final cartState = context.read<CartCubit>().state;
    if (cartState is CartLoaded && cartState.items.isNotEmpty) {
      final item = cartState.items.first;

      await getIt<NotificationService>().showPaymentSuccessNotification(
        productName: item.product.slug,
        productId: item.product.id,
      );

      if (!context.mounted) return;

      for (var cartItem in cartState.items) {
        final order = OrderEntity(
          id:
              DateTime.now().millisecondsSinceEpoch.toString() +
              cartItem.product.id,
          productId: cartItem.product.id,
          productName: cartItem.product.slug,
          imageUrl: cartItem.product.urls.small,
          date: DateTime.now(),
        );
        context.read<OrderCubit>().addOrder(order);
      }
    }

    if (!context.mounted) return;

    context.read<CartCubit>().clearCart();
    showSnakBar(context, "Payment Successful");

    if (locationState is LocationSuccess &&
        locationState.locations.isNotEmpty) {
      context.go(locationDetailsView);
    } else {
      context.go(addLocationView);
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
            _navigateAfterPayment(context);
          },
          onError: (error) {
            log("onError: $error");
            Navigator.pop(context);
            showSnakBar(context, error.toString(), isError: true);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  ({AmountModel amount, ItemListModel itemList}) getTransactionsData() {
    final amount = AmountModel(
      total: widget.checkoutSummary.totalCost.toString(),
      currency: "USD",
      details: AmountDetailsModel(
        subtotal: widget.checkoutSummary.totalCost.toString(),
        shipping: "0",
        shippingDiscount: 0,
      ),
    );

    final List<OrderItemModel> orders = [
      OrderItemModel(
        name: "Order Payment",
        quantity: 1,
        price: widget.checkoutSummary.totalCost.toString(),
        currency: "USD",
      ),
    ];

    final itemList = ItemListModel(orders: orders);
    return (amount: amount, itemList: itemList);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StripePaymentCubit, StripePaymentState>(
      listener: (context, state) {
        if (state is StripePaymentSuccess) {
          _navigateAfterPayment(context);
        }
      },
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
                    ValueListenableBuilder<String?>(
                      valueListenable: _selectedPaymentMethodNotifier,
                      builder: (context, value, child) {
                        return PaymentOptions(
                          selectedPayment: value,
                          onChanged: (newValue) {
                            _selectedPaymentMethodNotifier.value = newValue;
                          },
                        );
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
