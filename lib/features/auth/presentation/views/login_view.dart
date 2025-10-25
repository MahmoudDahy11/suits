import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/utils/assets.dart';
import 'package:suits/core/widgets/custom_button.dart';
import 'package:suits/core/widgets/custom_text_field.dart';

import 'widgets/card_view.dart';
import 'widgets/custom_divider.dart';
import 'widgets/custom_list_tile.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isObscure = false;
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
                  Text('Login', style: AppTextStyles.style18BoldBlack),
                  const SizedBox(height: spacebetweenSections),
                  const Text(
                    'Hi Welcome back, you’ve been missed',
                    style: AppTextStyles.style12SemiBoldBlack,
                  ),
                  const SizedBox(height: spacebetweenSections * 1.5),
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
                  const SizedBox(height: spacebetweenSections / 3),
                  GestureDetector(
                    onTap: () {
                      context.go(forgetPasswordView);
                    },
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password?',
                        style: AppTextStyles.style12BoldPrimaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: spacebetweenSections * 1.5),
                  CustomButton(
                    text: "Login",
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
                                  title: "Yeay! Welcome Back",
                                  description:
                                      "Once again you login successfully into medidoc app",
                                  titleButton: "Go to home",
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
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
                  GestureDetector(
                    onTap: () {
                      context.go(signupView);
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: "Don't have an account? ",
                        style: AppTextStyles.style15SemiBoldGrey,
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: AppTextStyles.style15BoldPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: spacebetweenSections),
                  const CustomDivider(),
                  const SizedBox(height: spacebetweenSections),
                  const CustomListTile(
                    title: 'Sign in with google',
                    icon: Assets.googlet,
                  ),
                  const SizedBox(height: spacebetweenSections),
                  const CustomListTile(
                    title: 'Sign in with Apple',
                    icon: Assets.applet,
                  ),
                  const SizedBox(height: spacebetweenSections),
                  const CustomListTile(
                    title: 'Sign in with facebook',
                    icon: Assets.facebookt,
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
