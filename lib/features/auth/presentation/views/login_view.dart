import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/helper/show_snak_bar.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/utils/assets.dart';
import 'package:suits/core/widgets/custom_button.dart';
import 'package:suits/core/widgets/custom_text_field.dart';
import 'package:suits/features/auth/presentation/cubits/google_cubit/google_cubit.dart';
import 'package:suits/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'widgets/card_view.dart';
import 'widgets/custom_divider.dart';
import 'widgets/custom_list_tile.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ValueNotifier<bool> isObscure = ValueNotifier(true);
  final ValueNotifier<bool> isEmptyEmail = ValueNotifier(true);
  final ValueNotifier<bool> isEmptyPassword = ValueNotifier(true);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email, password;
  @override
  void dispose() {
    isObscure.dispose();
    isEmptyEmail.dispose();
    isEmptyPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GoogleCubit, GoogleState>(
      listener: (context, state) {
        if (state is GoogleSuccess) {
          excuteDialog(context);
          showSnakBar(context, 'Google Sign-In Successful');
        } else if (state is GoogleFailure) {
          showSnakBar(context, state.errMessage, isError: true);
          log(state.errMessage);
        }
      },
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            excuteDialog(context);
            showSnakBar(context, 'Login Successful');
          } else if (state is LoginFailure) {
            showSnakBar(context, state.errMessage, isError: true);
            log(state.errMessage);
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: formKey,
              child: Scaffold(
                backgroundColor: Color(scafoldColor),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                      ),
                      child: Column(
                        children: [
                          Text('Login', style: AppTextStyles.style18BoldBlack),
                          const SizedBox(height: spacebetweenSections),
                          const Text(
                            'Hi Welcome back, you’ve been missed',
                            style: AppTextStyles.style12SemiBoldBlack,
                          ),
                          const SizedBox(height: spacebetweenSections * 1.5),
                          ValueListenableBuilder<bool>(
                            valueListenable: isEmptyEmail,
                            builder: (context, empty, _) {
                              return CustomTextField(
                                onSaved: (value) => email = value,
                                hintText: 'Enter your email',
                                onChanged: (value) =>
                                    isEmptyEmail.value = value.isEmpty,
                                prefixIcon: Image.asset(
                                  empty ? Assets.mails : Assets.emailss,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: spacebetweenSections / 2),
                          ValueListenableBuilder<bool>(
                            valueListenable: isObscure,
                            builder: (context, obscure, _) {
                              return ValueListenableBuilder<bool>(
                                valueListenable: isEmptyPassword,
                                builder: (context, empty, _) {
                                  return CustomTextField(
                                    onSaved: (value) => password = value,
                                    obscureText: obscure,
                                    onChanged: (value) =>
                                        isEmptyPassword.value = value.isEmpty,
                                    hintText: 'Enter your password',
                                    suffix: IconButton(
                                      onPressed: () =>
                                          isObscure.value = !isObscure.value,
                                      icon: Icon(
                                        !obscure
                                            ? CupertinoIcons.eye
                                            : Icons.visibility_off,
                                        color: Color(iconsColor),
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
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                context
                                    .read<LoginCubit>()
                                    .signInWithEmailAndPassword(
                                      email: email!,
                                      password: password!,
                                    );
                              }
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
                                    style:
                                        AppTextStyles.style15BoldPrimaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: spacebetweenSections),
                          const CustomDivider(),
                          const SizedBox(height: spacebetweenSections),
                          CustomListTile(
                            onTap: () {
                              BlocProvider.of<GoogleCubit>(
                                context,
                              ).signInWithGoogle();
                            },
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
            ),
          );
        },
      ),
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
  }
}
