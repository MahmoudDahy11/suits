import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/utils/assets.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(scafoldColor),
      body: Stack(
        children: [
          Image.asset(
            Assets.imagesSuit1,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * defaultHieghtOnbourding,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome To  Fashion',
                    style: AppTextStyles.style36BoldWhite,
                  ),
                  Text(
                    'Discover the latest trends and exclusive styles from our top designers',
                    style: AppTextStyles.style14RegularWhite,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
