import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/widgets/custom_button.dart';
import 'package:e_commerce_app/core/utils/widgets/custom_text_field.dart';
import 'package:e_commerce_app/features/profile/presentation/widgets/change_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileForm extends StatelessWidget {
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final bool isEditing;
  final VoidCallback onEditSavePressed;

  const ProfileForm({
    super.key,
    required this.userNameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.isEditing,
    required this.onEditSavePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 36.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('     Username', style: AppTextStyles.font14Bold),
          SizedBox(height: 5.h),
          CustomTextField(
            controller: userNameController,
            labelText: 'Username',
            enabled: isEditing,
          ),
          SizedBox(height: 5.h),
          Text('     Email', style: AppTextStyles.font14Bold),
          SizedBox(height: 5.h),
          CustomTextField(
            controller: emailController,
            labelText: 'Email',
            enabled: false,
          ),
          SizedBox(height: 5.h),
          Text('     Phone Number', style: AppTextStyles.font14Bold),
          SizedBox(height: 5.h),
          CustomTextField(
            controller: phoneNumberController,
            labelText: 'Phone Number',
            enabled: isEditing,
          ),
          const Padding(
            padding: EdgeInsets.all(22.0),
            child: ChangePasswordWidget(),
          ),
          SizedBox(height: 70.h),
          CustomButton(
            buttonText: isEditing ? 'Save' : 'Edit',
            onPressed: onEditSavePressed,
          ),
        ],
      ),
    );
  }
}