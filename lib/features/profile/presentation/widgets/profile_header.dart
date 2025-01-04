import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onChangePicture;

  const ProfileHeader({
    super.key,
    required this.imageUrl,
    required this.onChangePicture,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: Stack(
        children: [
          Container(
            width: double.infinity.w,
            height: 188.h,
            decoration: const BoxDecoration(color: AppColors.primaryColor),
          ),
          Positioned(
            top: 55.h,
            left: 144.w,
            child: Column(
              children: [
                Text('Profile', style: AppTextStyles.font16Bold),
                SizedBox(height: 40.h),
                Container(
                  width: 142.w,
                  height: 142.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      width: 7.w,
                      color: AppColors.scaffoldBackgroundLightColor,
                    ),
                  ),
                  child: imageUrl.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          Assets.profilePhoto,
                        ),
                ),
                TextButton(
                  onPressed: onChangePicture,
                  child: Text(
                    'Change Picture',
                    style: AppTextStyles.font14Regular,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}