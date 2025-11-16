import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/utils/home_assets.dart';
import 'package:suits/core/widgets/custom_button.dart';

class NewCollectionCard extends StatelessWidget {
  const NewCollectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
     
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'New Collection',
                  style: AppTextStyles.style16BoldBlack3,
                ),
                const SizedBox(height: spacebetweenSections / 3),
                const Text(
                  'Disscount 50% for \nthe first transaction',
                  style: AppTextStyles.style12RegularGrey,
                ),
                const SizedBox(height: spacebetweenSections / 2),
                SizedBox(
                  width: screenWidth * 0.35,
                  child: CustomButton(text: 'Shop Now', onTap: () {}),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          SizedBox(
            width: screenWidth * 0.28,
            child: Image.asset(HomeAssets.homeHomeCard, fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}
