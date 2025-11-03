import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.hintText,
    this.suffix,
    this.onSaved,
    this.obscureText = false,
    this.prefixIcon,
    this.onChanged,
  });
  final String hintText;
  final Widget? suffix;
  final Widget? prefixIcon;
  Function(String?)? onSaved;
  final Function(String)? onChanged;
  bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      errorBuilder: (context, error) => Text(
        error,
        style: TextStyle(color: Colors.red.shade700, fontSize: 12),
      ),
      obscureText: obscureText,
      onSaved: onSaved,
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        fillColor: const Color(fillColorTextField),
        suffixIcon: suffix,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xffA1A8B0),
          fontSize: 18,
          fontFamily: fontFamily,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xffE3E5E9), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xffC5C0BA), width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xffC5C0BA), width: 2),
        ),
      ),
    );
  }
}
