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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap ?? () {},
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(arrowIconColor),
            size: iconsSize,
          ),
        ),
        SizedBox(width: MediaQuery.sizeOf(context).width * 0.35),
        Text(title, style: AppTextStyles.style18BoldBlack),
      ],
    );
  }
}
