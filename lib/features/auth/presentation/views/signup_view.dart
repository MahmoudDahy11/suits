import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/utils/assets.dart';
import 'package:suits/core/widgets/custom_app_bar.dart';
import 'package:suits/core/widgets/custom_button.dart';
import 'package:suits/core/widgets/custom_text_field.dart';
import 'package:suits/features/auth/presentation/views/widgets/custom_check_box.dart';

import 'widgets/card_view.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool isObscure = false;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color(scafoldColor),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              children: [
                CustomAppBar(
                  title: "Sign Up",
                  onTap: () {
                    context.go(loginView);
                  },
                ),
                const SizedBox(height: spacebetweenSections),
                CustomTextField(
                  hintText: "Enter your name",
                  prefixIcon: Image.asset(Assets.users),
                ),
                const SizedBox(height: spacebetweenSections / 2),
                CustomTextField(
                  hintText: 'Enter your email',
                  prefixIcon: Image.asset(Assets.mails),
                ),
                const SizedBox(height: spacebetweenSections / 2),
                CustomTextField(
                  obscureText: isObscure,
                  hintText: 'Enter your password',
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: Icon(
                      isObscure ? CupertinoIcons.eye : Icons.visibility_off,
                      color: Color(iconsColor),
                      size: iconsSize,
                    ),
                  ),
                  prefixIcon: Image.asset(Assets.passwords),
                ),
                const SizedBox(height: spacebetweenSections / 2),
                Row(
                  children: [
                    CustomCheckBox(
                      onChanged: (value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                      check: isChecked,
                    ),
                    RichText(
                      text: const TextSpan(
                        text: 'I agree to the medidoc ',
                        style: AppTextStyles.style14RegularGrey,
                        children: [
                          TextSpan(
                            text: 'Terms of Service ',
                            style: AppTextStyles.style14RegularPrimary,
                          ),
                          TextSpan(
                            text: '\n and ',
                            style: AppTextStyles.style14RegularGrey,
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: AppTextStyles.style14RegularPrimary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: spacebetweenSections),
                CustomButton(
                  text: "Sign Up",
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext dialogContext) {
                        return Center(
                          child: FractionallySizedBox(
                            widthFactor: 0.8,
                            heightFactor: 0.5,
                            child: Material(
                              type: MaterialType.transparency,
                              child: CardView(
                                title: "Success",
                                description:
                                    "Your account has been successfully registered",
                                titleButton: "Login",
                                onPressed: () {
                                  context.go(loginView);
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: spacebetweenSections),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: AppTextStyles.style15SemiBoldGrey,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.go(loginView);
                      },
                      child: const Text(
                        'Login',
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
    );
  }
}
