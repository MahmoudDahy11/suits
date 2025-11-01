import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/utils/assets.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(scafoldColor),
      body: Stack(
        children: [
          Image.asset(
            Assets.imagesSuit2,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * defaultHieghtOnbourding,
            left: 0,
            right: 0,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Explore & Shop', style: AppTextStyles.style36BoldWhite),
                  Text(
                    'Discover a wide range of fashion categories, browse new arrivals and shop your favourites',
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
