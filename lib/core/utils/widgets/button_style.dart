import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonStyleWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;

  const ButtonStyleWidget({super.key, required this.buttonText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 435.w,
      height: 61.h,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
        ),
        child: Text(
          buttonText,
          style: AppTextStyles.font22Medium,
        ),
      ),
    );
  }
}
