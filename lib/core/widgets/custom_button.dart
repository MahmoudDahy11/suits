import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.check = false,
  });
  final String text;
  final VoidCallback onTap;
  final bool check;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: const Color(primaryColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: !check
                ? Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: fontFamily,
                    ),
                  )
                : const Center(
                    child: CupertinoActivityIndicator(
                      radius: 15.0,
                      color: Color(0xffF9FAFB),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
