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
  static const style24BoldBlack = TextStyle(
    color: Color(0xff101623),
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily3,
  );
  static const style18BoldBlack = TextStyle(
    color: Color(arrowIconColor),
    fontSize: 18,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily2,
  );
  static const style20BoldPrimaryColor = TextStyle(
    color: Color(primaryColor),
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily2,
  );
  static const style12BoldPrimaryColor = TextStyle(
    color: Color(primaryColor),
    fontSize: 12,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily3,
  );
  static const style15BoldPrimaryColor = TextStyle(
    color: Color(primaryColor),
    fontSize: 15,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily3,
  );
  static const style15SemiBoldGrey = TextStyle(
    color: Color(0xff727272),
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily3,
  );
  static const style12SemiBoldBlack = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily2,
  );
  static const style14RegularWhite = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static const style14RegularGrey = TextStyle(
    color: Color(0xff3B4453),
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily3,
  );
  static const style14RegularPrimary = TextStyle(
    color: Color(primaryColor),
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily3,
  );
  static const style16SemiBoldBlack = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily3,
  );
}
