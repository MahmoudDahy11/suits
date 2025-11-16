import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';

class IconArrowBack extends StatelessWidget {
  const IconArrowBack({super.key, required this.onTap});
 final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 16,
      child: IconButton(
        onPressed:onTap,
        icon: const Icon(Icons.arrow_back_ios, color: Color(arrowIconColor)),
      ),
    );
  }
}
