
import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/utils/home_assets.dart';
import 'package:suits/core/widgets/custom_button.dart';

class NewCollectionCard extends StatelessWidget {
  const NewCollectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.sizeOf(context).height * 0.2,
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Column(
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
                width: MediaQuery.sizeOf(context).width * 0.35,
                child: CustomButton(text: 'Shop Now', onTap: () {}),
              ),
            ],
          ),
          const Spacer(),
          Image.asset(HomeAssets.homeHomeCard),
        ],
      ),
    );
  }
}
