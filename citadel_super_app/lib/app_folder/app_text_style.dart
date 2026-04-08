import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  AppTextStyle._();

  static const _ITCAvantGarde = 'ITCAvantGardeStd';

  static final bigNumber = TextStyle(
    color: AppColor.white,
    fontFamily: _ITCAvantGarde,
    fontWeight: FontWeight.w600,
    fontSize: 32.spMin,
  );

  static final number = TextStyle(
    color: AppColor.white,
    fontFamily: _ITCAvantGarde,
    fontWeight: FontWeight.w500,
    fontSize: 24.spMin,
  );

  static final header1 = TextStyle(
    color: AppColor.white,
    fontFamily: _ITCAvantGarde,
    fontWeight: FontWeight.w600,
    fontSize: 24.spMin,
  );

  static final header2 = TextStyle(
    color: AppColor.white,
    fontFamily: _ITCAvantGarde,
    fontWeight: FontWeight.w600,
    fontSize: 20.spMin,
  );

  static final header3 = TextStyle(
    color: AppColor.white,
    fontFamily: _ITCAvantGarde,
    fontWeight: FontWeight.w600,
    fontSize: 16.spMin,
  );

  static final bodyText = TextStyle(
    color: AppColor.white,
    fontFamily: _ITCAvantGarde,
    fontWeight: FontWeight.w300,
    fontSize: 16.spMin,
  );

  static final action = TextStyle(
    color: AppColor.white,
    fontFamily: _ITCAvantGarde,
    fontWeight: FontWeight.w600,
    fontSize: 14.spMin,
  );

  static final description = TextStyle(
    color: AppColor.white,
    fontFamily: _ITCAvantGarde,
    fontWeight: FontWeight.w300,
    fontSize: 14.spMin,
  );

  static final label = TextStyle(
    color: AppColor.white,
    fontFamily: _ITCAvantGarde,
    fontWeight: FontWeight.w600,
    fontSize: 12.spMin,
  );

  static final caption = TextStyle(
    color: AppColor.white,
    fontFamily: _ITCAvantGarde,
    fontWeight: FontWeight.w300,
    fontSize: 12.spMin,
  );

  static final notificationDot = TextStyle(
    color: AppColor.white,
    fontFamily: _ITCAvantGarde,
    fontWeight: FontWeight.w500,
    fontSize: 10.spMin,
  );

  static final remark = TextStyle(
    color: AppColor.white,
    fontFamily: _ITCAvantGarde,
    fontWeight: FontWeight.w300,
    fontSize: 10.spMin,
  );
}
