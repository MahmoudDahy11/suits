import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    required this.onChanged,
    required this.check,
  });
  final bool check;
  final void Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Color(primaryColor),
      checkColor: Colors.white,
      side: BorderSide(color: Colors.grey.shade400, width: 1),
      value: check,
      onChanged: onChanged,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }
}
