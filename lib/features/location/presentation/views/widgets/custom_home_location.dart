import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';

class CustomHomeLocation extends StatelessWidget {
  const CustomHomeLocation({super.key, required this.address});
  final String address;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(scafoldColor)),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.location_on_sharp),
              SizedBox(width: spacebetweenSections / 2),
              Text('Home', style: AppTextStyles.style20BoldBlack),
            ],
          ),
          const SizedBox(height: spacebetweenSections / 2),
          Text(address, style: AppTextStyles.style15SemiBoldGrey),
          const SizedBox(height: spacebetweenSections / 2),
          Divider(thickness: 1.5, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}
