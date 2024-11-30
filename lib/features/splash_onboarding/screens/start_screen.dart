import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 253.h),
            Stack(
              children: [
                Image(
                  image: const AssetImage(Assets.circleShape),
                  width: 160.w,
                  height: 160.h,
                ),
                Positioned(
                  left: 42.w,
                  top: 30.h,
                  child: Image(
                    image: const AssetImage(Assets.logoApp),
                    width: 81.4.w,
                    height: 92.h,
                  ),
                ),
              ],
            ),
            SizedBox(height: 45.h),
            Text(
              'Shoppe',
              style: AppTextStyles.font52Bold,
            ),
            SizedBox(height: 18.h),
            Padding(
              padding: EdgeInsets.only(left: 63.w, right: 63.w),
              child: Text(
                'With just a few taps, place your order and have it on its way in no time',
                style: AppTextStyles.font16Medium,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 106.h),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Container(
                width: 335.w,
                height: 61.h,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(15.r)),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.register);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                  child: Text(
                    "Let's get started",
                    style: AppTextStyles.font22Medium,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, Routes.login);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'I already have an account',
                      style: AppTextStyles.font15Medium,
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(50.r)),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: AppColors.scaffoldBackgroundLightColor,
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
