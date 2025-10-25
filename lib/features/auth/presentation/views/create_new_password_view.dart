import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/utils/assets.dart';
import 'package:suits/core/widgets/custom_button.dart';
import 'package:suits/core/widgets/custom_text_field.dart';

import 'widgets/card_view.dart';

class CreateNewPasswordView extends StatefulWidget {
  const CreateNewPasswordView({super.key});

  @override
  State<CreateNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: spacebetweenSections),
                  Text(
                    'Create New Password',
                    style: AppTextStyles.style24BoldBlack,
                  ),
                  const SizedBox(height: spacebetweenSections / 2),
                  const Text(
                    'Create your new password to login',
                    style: AppTextStyles.style15SemiBoldGrey,
                  ),
                  const SizedBox(height: spacebetweenSections),
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
                  CustomTextField(
                    obscureText: isObscure,
                    hintText: 'Confirm your password',
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
                  const SizedBox(height: spacebetweenSections * 2),
                  CustomButton(
                    text: 'Create Password',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
