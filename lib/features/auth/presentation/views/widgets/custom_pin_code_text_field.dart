import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:suits/core/constant/app_constant.dart';

class CustomPinCodeTextField extends StatelessWidget {
  final Function(String)? onChanged;
  final Function(String)? onCompleted;

  const CustomPinCodeTextField({super.key, this.onChanged, this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      keyboardType: TextInputType.number,
      autoFocus: true,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: 70,
        fieldWidth: 70,
        activeFillColor: Color(fillColorTextField),
        selectedFillColor: Color(fillColorTextField),
        inactiveFillColor: Color(fillColorTextField),
        activeColor: Color(primaryColor),
        selectedColor: Color(primaryColor),
        inactiveColor: Colors.grey.shade500,
      ),
      enableActiveFill: true,
      onChanged: (value) {
        if (kDebugMode) {
          log(value);
        }
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      onCompleted: (value) {
        if (kDebugMode) {
          log("OTP Entered: $value");
        }
        if (onCompleted != null) {
          onCompleted!(value);
        }
      },
    );
  }
}
