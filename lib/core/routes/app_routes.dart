import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
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
    ],
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('الصفحة غير موجودة'))),
  );
}
