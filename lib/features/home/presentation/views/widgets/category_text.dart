import 'package:flutter/material.dart';
import 'package:suits/core/utils/app_text_style.dart';

class Categorytext extends StatelessWidget {
  const Categorytext({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Categories', style: AppTextStyles.style20BoldBlack3),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            'See All',
            style: AppTextStyles.style15SemiBoldGrey,
          ),
        ),
      ],
    );
  }
}
