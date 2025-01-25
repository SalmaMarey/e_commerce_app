import 'dart:io';

import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/widgets/custom_text_field.dart';
import 'package:e_commerce_app/features/auth/register/presentation/widgets/image_picker_widget.dart';
import 'package:e_commerce_app/features/auth/register/presentation/widgets/register_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;
  final TextEditingController userNameController;
  final File? selectedImage;
  final ValueChanged<File?> onImagePicked;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
    required this.userNameController,
    required this.selectedImage,
    required this.onImagePicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBox(height: 54.h),
        ImagePickerWidget(onImagePicked: onImagePicked),
        SizedBox(height: 54.h),
        CustomTextField(
          controller: emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email cannot be empty';
            }
            if (!value.contains('@') || !value.endsWith('.com')) {
              return 'Email must contain "@" and end with ".com"';
            }
            return null;
          },
          labelText: 'Email',
        ),
        SizedBox(height: 10.h),
        CustomTextField(
          controller: userNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'User name cannot be empty';
            }
            if (value.length < 3) {
              return 'Please write a valid name';
            }
            return null;
          },
          labelText: 'User name',
        ),
        SizedBox(height: 10.h),
        CustomTextField(
          controller: phoneController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Phone number cannot be empty';
            }
            if (value.length != 11) {
              return 'Phone number must be exactly 11 digits long';
            }
            return null;
          },
          labelText: 'Phone number',
        ),
        SizedBox(height: 10.h),
        CustomTextField(
          controller: passwordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password cannot be empty';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
          labelText: 'Password',
        ),
        SizedBox(height: 77.h),
        RegisterButton(
          formKey: formKey,
          userNameController: userNameController,
          emailController: emailController,
          phoneController: phoneController,
          passwordController: passwordController,
          selectedImage: selectedImage,
        ),
        SizedBox(height: 24.h),
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
    );
  }
}