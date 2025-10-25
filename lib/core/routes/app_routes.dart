import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/features/auth/presentation/views/create_new_password_view.dart';
import 'package:suits/features/auth/presentation/views/forget_password_view.dart';
import 'package:suits/features/auth/presentation/views/login_view.dart';
import 'package:suits/features/auth/presentation/views/otp_view.dart';
import 'package:suits/features/auth/presentation/views/signup_view.dart';
import 'package:suits/features/onboarding/root.dart';
import 'package:suits/features/onboarding/views/get_started.dart';
import 'package:suits/features/splash/splash.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const Splash(),
      ),
      GoRoute(
        path: root,
        name: 'root',
        builder: (context, state) => const Root(),
      ),
      GoRoute(
        path: getStarted,
        name: 'getStarted',
        builder: (context, state) => const GetStarted(),
      ),
      GoRoute(
        path: loginView,
        name: 'loginView',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: signupView,
        name: 'signupView',
        builder: (context, state) => const SignupView(),
      ),
      GoRoute(
        path: forgetPasswordView,
        name: 'forgetPassword',
        builder: (context, state) => const ForgetPasswordView(),
      ),
      GoRoute(
        path: otpView,
        name: 'otpView',
        builder: (context, state) => const OtpView(),
      ),
      GoRoute(
        path: createNewPasswordView,
        name: 'createNewPasswordView',
        builder: (context, state) => const CreateNewPasswordView(),
      ),
    ],
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('الصفحة غير موجودة'))),
  );
}
