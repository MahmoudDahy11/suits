import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/helper/show_snak_bar.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/widgets/custom_app_bar.dart';
import 'package:suits/core/widgets/custom_button.dart';
import 'package:suits/features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
import 'package:suits/features/auth/presentation/cubits/otp_cubit/otp_state.dart';

import 'widgets/card_view.dart';
import 'widgets/custom_pin_code_text_field.dart';

class OtpSignupView extends StatefulWidget {
  const OtpSignupView({super.key});

  @override
  State<OtpSignupView> createState() => _OtpSignupViewState();
}

class _OtpSignupViewState extends State<OtpSignupView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email!;
  String enteredOtp = "";

  int _secondsRemaining = 60;
  bool _canResend = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _canResend = false;
    _secondsRemaining = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpVerified) {
          excuteDialog(context);
          showSnakBar(context, 'Your account has been successfully registered');
        } else if (state is OtpError) {
          showSnakBar(context, state.errmessage, isError: true);
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
                      children: [
                        CustomAppBar(
                          title: '',
                          onTap: () {
                            context.go(forgetPasswordView);
                          },
                        ),
                        const SizedBox(height: spacebetweenSections / 2),
                        const Align(
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
                            text: TextSpan(
                              text:
                                  'Enter code that we have sent to your\n number ',
                              style: AppTextStyles.style15SemiBoldGrey,
                              children: [
                                TextSpan(
                                  text: email,
                                  style: AppTextStyles.style16SemiBoldBlack,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: spacebetweenSections),
                        CustomPinCodeTextField(
                          onChanged: (value) => log(value),
                          onCompleted: (value) {
                            log(value);
                            enteredOtp = value;
                          },
                        ),
                        const SizedBox(height: spacebetweenSections),
                        CustomButton(
                          check: state is OtpLoading,
                          text: 'Verify',
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context.read<OtpCubit>().verifyOtp(
                                uid: uid,
                                enteredOtp: enteredOtp,
                              );
                            }
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
                              onTap: _canResend
                                  ? () {
                                      context.read<OtpCubit>().sendOtp(
                                        uid: uid,
                                        email: email,
                                      );
                                      showSnakBar(
                                        context,
                                        "A new OTP has been sent to your email",
                                      );
                                      _startTimer();
                                    }
                                  : null,
                              child: Text(
                                _canResend
                                    ? 'Resend'
                                    : 'Resend in $_secondsRemaining s',
                                style: _canResend
                                    ? AppTextStyles.style15BoldPrimaryColor
                                    : AppTextStyles.style15SemiBoldGrey,
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
