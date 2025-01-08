import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderWidget extends StatelessWidget {
  final String? username;
  final VoidCallback onLogout;

  const HeaderWidget(
      {super.key, required this.username, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 58.h, left: 23.w, right: 21.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: CircleAvatar(
                  radius: 25.r,
                  backgroundColor: AppColors.textForm,
                  child: const Icon(
                    Icons.list,
                    size: 30,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: CircleAvatar(
                  radius: 25.r,
                  backgroundColor: AppColors.textForm,
                  child: const Icon(
                    Icons.search,
                    size: 30,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.logout, color: AppColors.primaryColor),
                onPressed: onLogout,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          username == null
              ? const CircularProgressIndicator()
              : Text(
                  'Hello, ${username ?? 'Guest'}!',
                  style: AppTextStyles.font20Bold,
                ),
          Text(
            'Let’s start shopping!',
            style: AppTextStyles.font16BoldGrey,
          ),
        ],
      ),
    );
  }
}
