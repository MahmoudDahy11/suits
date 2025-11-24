
import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';

import '../../../../../core/utils/app_text_style.dart';

class EditButtonLocation extends StatelessWidget {
  const EditButtonLocation({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(primaryColor)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Edit Your Location',
                  style: AppTextStyles.style20BoldBlack,
                ),
              ),
            ),
            Icon(Icons.edit, color: Color(primaryColor)),
          ],
        ),
      ),
    );
  }
}
