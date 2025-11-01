import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),  
      child: const Scaffold(
        backgroundColor: Color(scafoldColor),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Hello Safia" , style: AppTextStyles.style20BoldBlack,)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}