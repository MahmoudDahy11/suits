import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';

class CustomListTileProfile extends StatelessWidget {
  const CustomListTileProfile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        // margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Icon(icon, color: const Color(primaryColor), size: 30),
            const SizedBox(width: 30),
            Text(title, style: AppTextStyles.style20BoldBlack),
          ],
        ),
      ),
    );
  }
}
