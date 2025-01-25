// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:e_commerce_app/core/services/di.dart';
import 'package:e_commerce_app/core/utils/assets.dart';
import 'package:e_commerce_app/features/auth/register/presentation/controller/register_bloc.dart';
import 'package:e_commerce_app/features/auth/register/presentation/controller/register_state.dart';
import 'package:e_commerce_app/features/auth/register/presentation/widgets/register_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final userNameController = TextEditingController();
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<RegisterBloc>(),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration Successful!')),
            );
          } else if (state is RegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Stack(
                  children: [
                    Image.asset(Assets.register),
                    Positioned(
                      top: 122.h,
                      left: 30.w,
                      right: 30.w,
                      child: RegisterForm(
                        formKey: formKey,
                        emailController: emailController,
                        passwordController: passwordController,
                        phoneController: phoneController,
                        userNameController: userNameController,
                        selectedImage: selectedImage,
                        onImagePicked: (image) {
                          setState(() {
                            selectedImage = image;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
