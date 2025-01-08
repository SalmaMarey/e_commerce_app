import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OffersWidget extends StatelessWidget {
  const OffersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 20.h, right: 24.w, left: 24.w),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Row(
              children: [
                Container(
                  width: 285.w,
                  height: 130.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: AppColors.orangeContainer),
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 24.w, top: 19.h, right: 85.w),
                        child: Text(
                          '20% OFF DURING THE WEEKEND',
                          style: AppTextStyles.font16Bold,
                        ),
                      ),
                      Positioned(
                        top: 75.h,
                        left: 24.w,
                        child: Container(
                          width: 80.w,
                          height: 34.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.65.r),
                              color: AppColors.scaffoldBackgroundLightColor),
                          child: Center(
                            child: Text(
                              'Get Now',
                              style: AppTextStyles.font14Bold
                                  .copyWith(color: AppColors.orangeContainer),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 25.h,
                          left: 124.w,
                          right: -10.w,
                          child: Image.asset(
                            Assets.bagsImage,
                            width: 161.w,
                            height: 121.h,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  width: 19.w,
                ),
                Container(
                  width: 285.w,
                  height: 130.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: AppColors.primaryColor),
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 24.w, top: 19.h, right: 85.w),
                        child: Text(
                          '20% OFF DURING THE WEEKEND',
                          style: AppTextStyles.font16Bold,
                        ),
                      ),
                      Positioned(
                        top: 75.h,
                        left: 24.w,
                        child: Container(
                          width: 80.w,
                          height: 34.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.65.r),
                              color: AppColors.greenContainer),
                          child: Center(
                            child: Text(
                              'Get Now',
                              style: AppTextStyles.font14Bold.copyWith(
                                  color:
                                      AppColors.scaffoldBackgroundLightColor),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 25.h,
                          left: 124.w,
                          right: -10.w,
                          child: Image.asset(
                            Assets.bagsImage,
                            width: 161.w,
                            height: 121.h,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
