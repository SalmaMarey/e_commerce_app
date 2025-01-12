import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/app_text_styles.dart';

class ProductDetails extends StatelessWidget {
  final String category;
  final String title;
  final String description;

  const ProductDetails({
    super.key,
    required this.category,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 36.h),
        Text(
          category,
          style: AppTextStyles.font14Regular.copyWith(color: AppColors.grey0),
        ),
        SizedBox(height: 6.h),
        Text(
          title,
          style: AppTextStyles.font22Bold,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        Text(
          description,
          style: AppTextStyles.font14Regular.copyWith(color: AppColors.grey0),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
