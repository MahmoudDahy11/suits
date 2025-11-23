import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';
import 'package:suits/core/widgets/custom_button.dart';

class ThanksView extends StatelessWidget {
  const ThanksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(scafoldColor),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text('Payment ', style: AppTextStyles.style20BoldBlack3),
              ),
              const SizedBox(height: spacebetweenSections * 4),
              Container(
                decoration: const BoxDecoration(
                  color: Color(primaryColor),
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.check, color: Colors.white, size: 100),
                ),
              ),
              const SizedBox(height: spacebetweenSections),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Payment Successful! ',
                  style: AppTextStyles.style24BoldBlack,
                ),
              ),
              const SizedBox(height: spacebetweenSections / 3),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Thank you for your purchase.',
                  style: AppTextStyles.style14RegularGrey,
                ),
              ),
              const SizedBox(height: spacebetweenSections),
              const Spacer(),
              CustomButton(
                text: 'Go to Home',
                onTap: () {
                  context.go(homeRoot);
                },
              ),
              const SizedBox(height: spacebetweenSections),
            ],
          ),
        ),
      ),
    );
  }
}
