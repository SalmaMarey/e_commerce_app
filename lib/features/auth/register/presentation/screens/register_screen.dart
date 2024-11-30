import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Image.asset(Assets.register),
          Positioned(
              top: 122.h,
              left: 30.w,
              right: 30.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: 'Create\n',
                      style: AppTextStyles.font50Bold,
                      children: const [
                        TextSpan(
                          text: 'Account',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 54.h,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      Assets.uploadPhoto,
                      height: 90.h,
                      width: 90.w,
                    ),
                  ),
                  SizedBox(
                    height: 54.h,
                  ),
                  Container(
                    width: 434.w,
                    height: 52.22.h,
                    decoration: BoxDecoration(
                        color: AppColors.textForm,
                        borderRadius: BorderRadius.circular(59.12.r)),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 15.h,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 434.w,
                    height: 52.22.h,
                    decoration: BoxDecoration(
                        color: AppColors.textForm,
                        borderRadius: BorderRadius.circular(59.12.r)),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 15.h,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 434.w,
                    height: 52.22.h,
                    decoration: BoxDecoration(
                        color: AppColors.textForm,
                        borderRadius: BorderRadius.circular(59.12.r)),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Phone number',
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 15.h,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 77.h,
                  ),
                  Container(
                    width: 435.w,
                    height: 61.h,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(15.r)),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.pushReplacementNamed(context, Routes.register);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                      ),
                      child: Text(
                        "Done",
                        style: AppTextStyles.font22Medium,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Routes.login);
                      },
                      child: Text(
                        'Cancel',
                        style: AppTextStyles.font15Medium,
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    ));
  }
}
