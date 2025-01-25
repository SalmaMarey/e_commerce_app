import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/widgets/custom_button.dart';
import 'package:e_commerce_app/core/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLoginPressed;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onLoginPressed,
  });

  bool _validateEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email);
  }

  bool _validatePassword(String password) {
    return password.length >= 6;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login',
            style: AppTextStyles.font52Bold,
          ),
          Text(
            'Good to see you back! 🖤',
            style: AppTextStyles.font19Regular,
          ),
          SizedBox(height: 17.08.h),
          CustomTextField(
            controller: emailController,
            validator: (value) {
              if (value == null || !_validateEmail(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            labelText: 'Email',
          ),
          SizedBox(height: 10.h),
          CustomTextField(
            controller: passwordController,
            validator: (value) {
              if (value == null || !_validatePassword(value)) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
            labelText: 'Password',
          ),
          SizedBox(height: 10.h),
          SizedBox(height: 57.h),
          CustomButton(
            onPressed: onLoginPressed,
            buttonText: 'Done',
          ),
        ],
      ),
    );
  }
}