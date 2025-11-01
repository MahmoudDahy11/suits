import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:suits/features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
import 'package:suits/features/auth/presentation/cubits/otp_cubit/otp_state.dart';
import 'widgets/auth_toggle_swich.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final ValueNotifier<int> _authController = ValueNotifier(0);
  final ValueNotifier<String> _inputValue = ValueNotifier('');
  String? email, phoneNumber;
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _authController.dispose();
    _inputValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpError) {
          showSnakBar(context, state.errmessage, isError: true);
        } else if (state is OtpSent) {
          showSnakBar(context, 'OTP sent successfully');
          context.go(otpResetPasswordView);
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
                        const SizedBox(height: spacebetweenSections / 2),
                        const Text(
                          'Forgot Your Password?',
                          style: AppTextStyles.style24BoldBlack,
                        ),
                        const SizedBox(height: spacebetweenSections / 2),
                        const Text(
                          'Enter your email or your phone number, we will send you confirmation code',
                          style: AppTextStyles.style15SemiBoldGrey,
                        ),
                        const SizedBox(height: spacebetweenSections * 2),
                        AuthToggleSwitch(
                          controller: _authController,
                          onToggle: (value) => _authController.value = value,
                        ),
                        const SizedBox(height: spacebetweenSections),
                        ValueListenableBuilder<int>(
                          valueListenable: _authController,
                          builder: (context, index, _) {
                            if (index == 0) {
                              return ValueListenableBuilder<String>(
                                valueListenable: _inputValue,
                                builder: (context, text, _) {
                                  return CustomTextField(
                                    onSaved: (value) {
                                      email = value;
                                    },
                                    onChanged: (value) =>
                                        _inputValue.value = value,
                                    hintText: 'Enter your email',
                                    prefixIcon: text.isEmpty
                                        ? Image.asset(Assets.mails)
                                        : Image.asset(Assets.emailss),
                                  );
                                },
                              );
                            } else {
                              return CustomTextField(
                                onSaved: (value) {
                                  phoneNumber = value;
                                },
                                hintText: 'Enter your phone number',
                                prefixIcon: Image.asset(Assets.calls),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: spacebetweenSections * 2),

                        CustomButton(
                          check: state is OtpLoading,
                          text: 'Reset Password',
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                            }
                            final enteredEmail = email.toString().trim();
                            final user = auth.currentUser;

                            if (user == null) {
                              showSnakBar(
                                context,
                                "user not found",
                                isError: true,
                              );
                              return;
                            }

                            if (enteredEmail != user.email) {
                              showSnakBar(
                                context,
                                "Entered email does not match the logged-in user's email.",
                                isError: true,
                              );
                              return;
                            }

                            context.read<OtpCubit>().sendOtp(
                              uid: user.uid,
                              email: enteredEmail,
                            );
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
}
