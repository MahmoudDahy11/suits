import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suits/core/constant/app_constant.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    super.key,
    required this.hintText,
    required this.onSaved,
    required this.onChanged,
    this.prefixIcon,
  });

  final String hintText;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
      ],

      onChanged: onChanged,
      onSaved: onSaved,

      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }

        if (!value.startsWith("01")) {
          return 'Phone must start with 01';
        }

        if (value.length != 11) {
          return 'Phone must be 11 digits';
        }

        return null;
      },

      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        fillColor: const Color(fillColorTextField),
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
