import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
  });
  final VoidCallback? onTap;
  final String title;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffE3E5E9), width: 2),
          color: Color(fillColorTextField),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Image.asset(icon),
            SizedBox(width: MediaQuery.sizeOf(context).width * 0.2),
            Text(title, style: AppTextStyles.style16SemiBoldBlack),
          ],
        ),
      ),
    );
  }
}
