import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/utils/assets.dart';
import 'package:suits/core/widgets/custom_button.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(scafoldColor),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(Assets.imagesGetStarted1, fit: BoxFit.cover),
                    Column(
                      children: [
                        Image.asset(
                          Assets.imagesGetStarted2,
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          Assets.imagesGetStarted3,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: spacebetweenSections * 2),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'The ',
                        style: AppTextStyles.style20BoldBlack,
                      ),
                      TextSpan(
                        text: 'Suits App',
                        style: AppTextStyles.style20BoldPrimaryColor,
                      ),

                      TextSpan(
                        text: ' that\n',
                        style: AppTextStyles.style20BoldBlack,
                      ),

                      TextSpan(
                        text: 'Makes Your Look Your Best',
                        style: AppTextStyles.style20BoldBlack,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: spacebetweenSections),
                const Text(
                  'Everything you need in the world\n of fashion, old and new',

                  textAlign: TextAlign.center,
                  style: AppTextStyles.style15SemiBoldGrey,
                ),

                const SizedBox(height: spacebetweenSections * 5),
                CustomButton(
                  text: "Get started",
                  onTap: () {
                    context.go(loginView);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
