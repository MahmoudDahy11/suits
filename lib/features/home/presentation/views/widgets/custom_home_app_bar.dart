
import 'package:flutter/material.dart';
import 'package:suits/core/utils/app_text_style.dart';

import '../../../../../core/constant/app_constant.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Hello Mahmoud", style: AppTextStyles.style20BoldBlack3),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: const Icon(
            Icons.notifications_outlined,
            color: Color(primaryColor),
          ),
        ),
      ],
    );
  }
}