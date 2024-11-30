import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingDetails extends StatelessWidget {
  final String image;
  final String shape;
  final String title;
  final String description;
  final bool isSecondOnboarding;
  final bool isThirdOnboarding;
  final bool isFirstOnboarding;

  const OnboardingDetails({
    super.key,
    required this.image,
    required this.shape,
    required this.title,
    required this.description,
    this.isSecondOnboarding = false,
    this.isThirdOnboarding = false,
    this.isFirstOnboarding = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          child: Stack(
            children: [
              Image.asset(
                shape,
              ),
              Positioned(
                top: 123.h,
                left: 20.w,
                child: Column(
                  children: [
                    Image.asset(
                      Assets.cartIcon,
                      width: 55.w,
                      height: 55.h,
                    ),
                    Text(
                      'Shoppe App',
                      style: AppTextStyles.font28Bold,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: isSecondOnboarding
              ? EdgeInsets.symmetric(vertical: 90.h)
              : EdgeInsets.zero,
          child: Center(
            child: Image.asset(
              image,
              height: isThirdOnboarding ? 343.h : 298.h,
              width: isThirdOnboarding ? 280.w : 316.w,
            ),
          ),
        ),
        SizedBox(height: 35.h),
        Padding(
          padding: isFirstOnboarding
              ? EdgeInsets.symmetric(vertical: 50.h)
              : EdgeInsets.zero,
          child: Column(
            children: [
              Center(
                child: Text(title, style: AppTextStyles.font26Bold),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  description,
                  style: AppTextStyles.font16Medium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
