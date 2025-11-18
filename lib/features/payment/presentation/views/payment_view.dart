import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/widgets/custom_app_bar.dart';
import 'package:suits/core/widgets/custom_button.dart';
import 'package:suits/core/widgets/custom_text_field.dart';

import 'widgets/payment_options.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onTap: () => context.pop(),
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
                const PaymentOptions(),
                const Spacer(),
                CustomButton(text: 'Confirm Payment', onTap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
