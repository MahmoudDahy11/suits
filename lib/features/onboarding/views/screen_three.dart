import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/utils/assets.dart';

class ScreenThree extends StatelessWidget {
  const ScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(scafoldColor),
      body: Stack(
        children: [
          Image.asset(
            Assets.imagesSuit3,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * .75,
            left: 0,
            right: 0,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hi,Shop Now', style: AppTextStyles.style36BoldWhite),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
