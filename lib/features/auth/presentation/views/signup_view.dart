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
  final ValueNotifier<String> nameValue = ValueNotifier('');
  final ValueNotifier<String> emailValue = ValueNotifier('');
  final ValueNotifier<String> passwordValue = ValueNotifier('');
  final ValueNotifier<bool> isObscure = ValueNotifier(false);
  final ValueNotifier<bool> isChecked = ValueNotifier(false);

  @override
  void dispose() {
    nameValue.dispose();
    emailValue.dispose();
    passwordValue.dispose();
    isObscure.dispose();
    isChecked.dispose();
    super.dispose();
  }

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
                ValueListenableBuilder<String>(
                  valueListenable: nameValue,
                  builder: (context, value, _) {
                    return CustomTextField(
                      onChanged: (val) => nameValue.value = val,
                      hintText: "Enter your name",
                      prefixIcon: value.isEmpty
                          ? Image.asset(Assets.users)
                          : Image.asset(Assets.userss),
                    );
                  },
                ),
                const SizedBox(height: spacebetweenSections / 2),
                ValueListenableBuilder<String>(
                  valueListenable: emailValue,
                  builder: (context, value, _) {
                    return CustomTextField(
                      onChanged: (val) => emailValue.value = val,
                      hintText: 'Enter your email',
                      prefixIcon: value.isEmpty
                          ? Image.asset(Assets.mails)
                          : Image.asset(Assets.emailss),
                    );
                  },
                ),
                const SizedBox(height: spacebetweenSections / 2),
                ValueListenableBuilder<String>(
                  valueListenable: passwordValue,
                  builder: (context, value, _) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: isObscure,
                      builder: (context, obscure, _) {
                        return CustomTextField(
                          onChanged: (val) => passwordValue.value = val,
                          obscureText: obscure,
                          hintText: 'Enter your password',
                          suffix: IconButton(
                            onPressed: () => isObscure.value = !isObscure.value,
                            icon: Icon(
                              obscure
                                  ? CupertinoIcons.eye
                                  : Icons.visibility_off,
                              color: Color(iconsColor),
                              size: iconsSize,
                            ),
                          ),
                          prefixIcon: value.isEmpty
                              ? Image.asset(Assets.passwords)
                              : Image.asset(Assets.passwordss),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: spacebetweenSections / 2),
                ValueListenableBuilder<bool>(
                  valueListenable: isChecked,
                  builder: (context, checked, _) {
                    return Row(
                      children: [
                        CustomCheckBox(
                          onChanged: (value) =>
                              isChecked.value = value ?? false,
                          check: checked,
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
                    );
                  },
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
