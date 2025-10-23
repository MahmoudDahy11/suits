
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
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
      
    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text('الصفحة غير موجودة',),
      ),
    ),
  );
}
