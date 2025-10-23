import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';

abstract class AppTextStyles {
  static const style36BoldWhite = TextStyle(
    color: Colors.white,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static const style20BoldBlack = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily2,
  );
  static const style20BoldPrimaryColor = TextStyle(
    color: Color(primaryColor),
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily2,
  );
  static const style15SemiBoldGrey = TextStyle(
    color: Color(0xff727272),
    fontSize: 15,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily2,
  );
  static const style14RegularWhite = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
}
