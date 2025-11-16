import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title, this.onTap});
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onTap ?? () {},
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color(arrowIconColor),
            size: iconsSize,
          ),
        ),

        Text(title, style: AppTextStyles.style18BoldBlack),
        const SizedBox(width: iconsSize),
      ],
    );
  }
}
