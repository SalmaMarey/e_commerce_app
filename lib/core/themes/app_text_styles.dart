import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppTextStyles {
  AppTextStyles._();

  static TextStyle get font21BoldDarkBlue => TextStyle(
        fontSize: 21.sp,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get font28BoldDarkBlue => TextStyle(
        fontSize: 28.sp,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get font18Medium => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get font15MediumGrey => TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    // color: AppColors.grey
  );

  static TextStyle get font15MediumBlueGrey => TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryColor
  );

  static TextStyle get font20Regular => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get font20Bold => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get font16Regular => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get font14Regular => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get font14Bold => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get font16Bold => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      );

}
