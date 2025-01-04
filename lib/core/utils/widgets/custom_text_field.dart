import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final bool enabled; // Add this parameter

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.enabled = true, // Default to true
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.labelText == 'Password' ? !_isPasswordVisible : false,
      enabled: widget.enabled, // Use the enabled parameter
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.textForm,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: widget.labelText,
        labelStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(59.12.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(style: BorderStyle.none),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        suffixIcon: widget.labelText == 'Password'
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: _togglePasswordVisibility,
              )
            : null,
      ),
      style: TextStyle(fontSize: 16.sp, color: Colors.black),
    );
  }
}