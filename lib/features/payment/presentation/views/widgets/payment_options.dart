import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';

import '../../../../../core/utils/assets.dart';

class PaymentOptions extends StatefulWidget {
  final Function(String?) onChanged;
  final String? selectedPayment;

  const PaymentOptions({
    super.key,
    required this.onChanged,
    required this.selectedPayment,
  });

  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
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
            icon: ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [Color(0xFF003087), Color(0xFF009CDE)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: const Icon(
                Icons.paypal_outlined,
                size: 28,
                color: Colors.white,
              ),
            ),
            title: 'Pay Pal',
            value: 'paypal',
          ),
          Divider(color: Colors.grey.shade400),
          _paymentRow(
            icon: ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [Color(0xFF6772E5), Color(0xFFAC39FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: const Icon(
                Icons.strikethrough_s_sharp,
                size: 28,
                color: Colors.white,
              ),
            ),
            title: 'Stripe Payment',
            value: 'stripe',
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
    return Row(
      children: [
        const SizedBox(width: 15),
        icon,
        const Spacer(flex: 1),
        Text(title, style: AppTextStyles.style14RegularGrey),
        const Spacer(flex: 4),
        Checkbox(
          value: widget.selectedPayment == value,
          onChanged: (_) {
            final String? newValue = widget.selectedPayment == value
                ? null
                : value;
            widget.onChanged(newValue);
          },
          activeColor: const Color(primaryColor),
          side: BorderSide(color: Colors.grey.shade400),
          shape: const CircleBorder(),
        ),
      ],
    );
  }
}
