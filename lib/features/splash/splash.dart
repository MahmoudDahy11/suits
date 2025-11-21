import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/assets.dart';
import 'dart:async';
import '../auth/data/service/local_storage.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    _initializeAndNavigate();
  }

  Future<void> _initializeAndNavigate() async {
    await LocalStorageService.init();
    final user = FirebaseAuth.instance.currentUser;
    final bool loggedIn = LocalStorageService.isLoggedIn();

    final delay = const Duration(seconds: 3) - const Duration(seconds: 2);
    await Future.delayed(delay);

    if (mounted) {
      if (loggedIn && user != null) {
        context.go(homeRoot);
      } else {
        context.go(root);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(splashColor),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  padding: const EdgeInsets.all(defaultCirclerpadding),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: SvgPicture.asset(
                    Assets.imagesSuitsLogo,
                    height: 60,
                    width: 50,
                  ),
                ),
                const SizedBox(width: 16),
                Image.asset(Assets.imagesSuits),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
