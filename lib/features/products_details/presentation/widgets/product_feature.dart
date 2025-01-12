import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductFeatures extends StatelessWidget {
  const ProductFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: AppColors.greyContainer,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildFeature(Icons.star, '4.6/5'),
            _buildFeature(Icons.auto_awesome_motion_outlined, 'Comfort'),
            _buildFeature(Icons.done_all, 'Durable'),
            _buildFeature(Icons.verified_user, 'Adaptive'),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String label) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.primaryColor,
        ),
        SizedBox(height: 10.h),
        Text(
          label,
          style: AppTextStyles.font16Bold.copyWith(color: AppColors.textColor),
        ),
      ],
    );
  }
}
