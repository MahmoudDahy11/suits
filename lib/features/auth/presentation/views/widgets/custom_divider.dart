import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade400, thickness: .7)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Text(
            'OR',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w400,
              fontFamily: fontFamily3,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade400, thickness: .7)),
      ],
    );
  }
}
