import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/widgets/custom_button.dart';

class CardView extends StatelessWidget {
  const CardView({
    super.key,
    required this.title,
    required this.description,
    required this.onPressed,
    required this.titleButton,
  });
  final String? title;
  final String? description;
  final VoidCallback? onPressed;
  final String? titleButton;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xffF5F8FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Color(primaryColor), size: 60),
              ),
              const SizedBox(height: spacebetweenSections),
              Text(title ?? '', style: AppTextStyles.style20BoldBlack),
              const SizedBox(height: spacebetweenSections / 2),
              Text(
                textAlign: TextAlign.center,
                description ?? '',
                style: AppTextStyles.style15SemiBoldGrey,
              ),
              const Spacer(),
              CustomButton(text: titleButton ?? '', onTap: onPressed ?? () {}),
              const SizedBox(height: spacebetweenSections * 1.5),
            ],
          ),
        ),
      ),
    );
  }
}
