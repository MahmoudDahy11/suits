
import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';

import '../../../../../core/utils/assets.dart';

class PaymentOptions extends StatefulWidget {
  const PaymentOptions({super.key});

  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  final ValueNotifier<String?> selectedPayment = ValueNotifier<String?>(null);

  @override
  void dispose() {
    selectedPayment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _paymentRow(
            icon: const Icon(Icons.paypal_outlined),
            title: 'Pay Pal',
            value: 'paypal',
          ),
          Divider(color: Colors.grey.shade400),
          _paymentRow(
            icon: Image.asset(Assets.applet),
            title: 'Apple Pay',
            value: 'apple',
          ),
          Divider(color: Colors.grey.shade400),
          _paymentRow(
            icon: Image.asset(Assets.googlet),
            title: 'Google',
            value: 'google',
          ),
        ],
      ),
    );
  }

  Widget _paymentRow({
    required Widget icon,
    required String title,
    required String value,
  }) {
    return ValueListenableBuilder<String?>(
      valueListenable: selectedPayment,
      builder: (context, selected, _) {
        return Row(
          children: [
            const SizedBox(width: 15),
            icon,
            const Spacer(flex: 1),
            Text(title, style: AppTextStyles.style14RegularGrey),
            const Spacer(flex: 4),
            Checkbox(
              value: selected == value,
              onChanged: (_) {
                if (selected == value) {
                  selectedPayment.value = null;
                } else {
                  selectedPayment.value = value;
                }
              },
              activeColor: const Color(primaryColor),
              side: BorderSide(color: Colors.grey.shade400),
              shape: const CircleBorder(),
            ),
          ],
        );
      },
    );
  }
}
