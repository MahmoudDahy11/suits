import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/widgets/custom_app_bar.dart';
import 'package:suits/core/widgets/custom_button.dart';

import 'widgets/custom_pin_code_text_field.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color(scafoldColor),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                children: [
                  CustomAppBar(
                    title: '',
                    onTap: () {
                      context.go(forgetPasswordView);
                    },
                  ),
                  const SizedBox(height: spacebetweenSections / 2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Enter Verification Code',
                      style: AppTextStyles.style24BoldBlack,
                    ),
                  ),
                  const SizedBox(height: spacebetweenSections / 2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: const TextSpan(
                        text: 'Enter code that we have sent to your\n number ',
                        style: AppTextStyles.style15SemiBoldGrey,
                        children: [
                          TextSpan(
                            text: '+123 456 7890',
                            style: AppTextStyles.style16SemiBoldBlack,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: spacebetweenSections),
                  const CustomPinCodeTextField(),
                  const SizedBox(height: spacebetweenSections),
                  CustomButton(
                    text: 'Verify',
                    onTap: () {
                      context.go(createNewPasswordView);
                    },
                  ),
                  const SizedBox(height: spacebetweenSections),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Didn’t receive the code?  ',
                        style: AppTextStyles.style15SemiBoldGrey,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go(loginView);
                        },
                        child: const Text(
                          'Resend',
                          style: AppTextStyles.style15BoldPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
