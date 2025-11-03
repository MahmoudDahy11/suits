
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';

class IconArrowBack extends StatelessWidget {
  const IconArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 16,
      child: IconButton(
        onPressed: () {
          context.go(homeRoot);
        },
        icon: const Icon(Icons.arrow_back_ios, color: Color(arrowIconColor)),
      ),
    );
  }
}
