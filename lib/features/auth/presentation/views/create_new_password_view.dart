import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/helper/show_snak_bar.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/utils/assets.dart';
import 'package:suits/core/widgets/custom_app_bar.dart';
import 'package:suits/core/widgets/custom_button.dart';
import 'package:suits/core/widgets/custom_text_field.dart';
import 'package:suits/features/auth/presentation/cubits/forget_password_cubit/forget_password_cubit.dart';

import 'widgets/card_view.dart';

class CreateNewPasswordView extends StatefulWidget {
  const CreateNewPasswordView({super.key});

  @override
  State<CreateNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
  final ValueNotifier<bool> isObscure = ValueNotifier(true);
  final ValueNotifier<bool> isEmpty1 = ValueNotifier(true);
  final ValueNotifier<bool> isEmpty2 = ValueNotifier(true);
  String? password, confirmPassword;
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    isObscure.dispose();
    isEmpty1.dispose();
    isEmpty2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          showSnakBar(context, 'Password created successfully');
          excuteDialog(context);
        } else if (state is ForgetPasswordFailure) {
          showSnakBar(context, state.errMessage, isError: true);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: formKey,
            child: Scaffold(
              backgroundColor: const Color(scafoldColor),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppBar(
                          title: '',
                          onTap: () => context.go(loginView),
                        ),
                        const SizedBox(height: spacebetweenSections),
                        const Text(
                          'Create New Password',
                          style: AppTextStyles.style24BoldBlack,
                        ),
                        const SizedBox(height: spacebetweenSections / 2),
                        const Text(
                          'Create your new password to login',
                          style: AppTextStyles.style15SemiBoldGrey,
                        ),
                        const SizedBox(height: spacebetweenSections),
                        ValueListenableBuilder<bool>(
                          valueListenable: isObscure,
                          builder: (context, obscure, _) {
                            return ValueListenableBuilder<bool>(
                              valueListenable: isEmpty1,
                              builder: (context, empty, _) {
                                return CustomTextField(
                                  onSaved: (value) {
                                    password = value;
                                  },
                                  onChanged: (value) =>
                                      isEmpty1.value = value.isEmpty,
                                  obscureText: obscure,
                                  hintText: 'Enter your password',
                                  suffix: IconButton(
                                    onPressed: () =>
                                        isObscure.value = !isObscure.value,
                                    icon: Icon(
                                      !obscure
                                          ? CupertinoIcons.eye
                                          : Icons.visibility_off,
                                      color: const Color(iconsColor),
                                      size: iconsSize,
                                    ),
                                  ),
                                  prefixIcon: Image.asset(
                                    empty
                                        ? Assets.passwords
                                        : Assets.passwordss,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: spacebetweenSections / 2),
                        ValueListenableBuilder<bool>(
                          valueListenable: isObscure,
                          builder: (context, obscure, _) {
                            return ValueListenableBuilder<bool>(
                              valueListenable: isEmpty2,
                              builder: (context, empty, _) {
                                return CustomTextField(
                                  onSaved: (value) {
                                    confirmPassword = value;
                                  },
                                  onChanged: (value) =>
                                      isEmpty2.value = value.isEmpty,
                                  obscureText: obscure,
                                  hintText: 'Confirm your password',
                                  suffix: IconButton(
                                    onPressed: () =>
                                        isObscure.value = !isObscure.value,
                                    icon: Icon(
                                      !obscure
                                          ? CupertinoIcons.eye
                                          : Icons.visibility_off,
                                      color: const Color(iconsColor),
                                      size: iconsSize,
                                    ),
                                  ),
                                  prefixIcon: Image.asset(
                                    empty
                                        ? Assets.passwords
                                        : Assets.passwordss,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: spacebetweenSections * 2),
                        CustomButton(
                          check: state is ForgetPasswordLoading,
                          text: 'Create Password',
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              if (password != confirmPassword) {
                                showSnakBar(
                                  context,
                                  "Passwords do not match",
                                  isError: true,
                                );
                                return;
                              } else if (password == confirmPassword) {
                                context
                                    .read<ForgetPasswordCubit>()
                                    .resetPassword(password!);
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void excuteDialog(BuildContext context) {
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
                description: "Your account has been successfully registered",
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
  }
}
