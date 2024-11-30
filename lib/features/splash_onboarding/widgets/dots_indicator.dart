import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DotsIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  const DotsIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          width: 10.w,
          height: 10.h,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == index
                  ? AppColors.primaryColor
                  : AppColors.inActiveDots),
        );
      }),
    );
  }
}
