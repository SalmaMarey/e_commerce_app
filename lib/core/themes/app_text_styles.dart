import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get font28Bold => TextStyle(
        fontSize: 28.sp,
        color: AppColors.textColor,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get font26Bold => TextStyle(
        fontSize: 26.sp,
        color: AppColors.textColor,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get font18Bold => TextStyle(
        fontSize: 18.sp,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get font52Bold => TextStyle(
        fontSize: 52.sp,
        color: AppColors.textColor,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get font50Bold => TextStyle(
        fontSize: 50.sp,
        color: AppColors.textColor,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get font16Medium => TextStyle(
        fontSize: 16.sp,
        color: AppColors.textColor,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get font18Medium => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textColor,
      );
  static TextStyle get font15Medium => TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textColor,
      );
  static TextStyle get font22Medium => TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.scaffoldBackgroundLightColor);

  static TextStyle get font20Regular => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get font20Bold => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get font19Regular => TextStyle(
        fontSize: 19.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textColor,
      );
  static TextStyle get font14Regular => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryColor,
      );
  static TextStyle get font14Bold => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      );
  static TextStyle get font16Bold => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.scaffoldBackgroundLightColor,
      );
}
