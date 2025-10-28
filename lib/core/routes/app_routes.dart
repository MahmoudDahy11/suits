import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/service/get_it.dart';
import 'package:suits/features/auth/presentation/cubits/forget_password_cubit/forget_password_cubit.dart';
import 'package:suits/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:suits/features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
import 'package:suits/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:suits/features/auth/presentation/views/create_new_password_view.dart';
import 'package:suits/features/auth/presentation/views/forget_password_view.dart';
import 'package:suits/features/auth/presentation/views/login_view.dart';
import 'package:suits/features/auth/presentation/views/otp_reset_password_view.dart';
import 'package:suits/features/auth/presentation/views/otp_signup_view.dart';
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
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: signupView,
        name: 'signupView',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<SignupCubit>(),
          child: const SignupView(),
        ),
      ),
      GoRoute(
        path: forgetPasswordView,
        name: 'forgetPassword',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<OtpCubit>(),
          child: const ForgetPasswordView(),
        ),
      ),
      GoRoute(
        path: otpSignupView,
        name: 'otpSignupView',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<OtpCubit>(),
          child: const OtpSignupView(),
        ),
      ),
      GoRoute(
        path: otpResetPasswordView,
        name: 'otpResetPasswordView',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<OtpCubit>(),
          child: const OtpResetPasswordView(),
        ),
      ),
      GoRoute(
        path: createNewPasswordView,
        name: 'createNewPasswordView',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<ForgetPasswordCubit>(),
          child: const CreateNewPasswordView(),
        ),
      ),
    ],
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('الصفحة غير موجودة'))),
  );
}
