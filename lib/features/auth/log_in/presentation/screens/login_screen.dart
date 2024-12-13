import 'package:e_commerce_app/core/services/di.dart';
import 'package:e_commerce_app/core/utils/assets.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/widgets/custom_text_field.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/bloc/login_bloc.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/bloc/login_state.dart';
import 'package:e_commerce_app/features/auth/log_in/presentation/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _validateEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email);
  }

  bool _validatePassword(String password) {
    return password.length >= 6;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<LoginBloc>(),
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Scaffold(
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Image.asset(Assets.login),
                    Positioned(
                      top: 438.h,
                      left: 20.w,
                      right: 20.w,
                      child: Form(
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
                            SizedBox(
                              height: 17.08.h,
                            ),
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
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTextField(
                              controller: passwordController,
                              validator: (value) {
                                if (value == null ||
                                    !_validatePassword(value)) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              labelText: 'Password',
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            SizedBox(
                              height: 57.h,
                            ),
                            LoginButton(
                              emailController: emailController,
                              passwordController: passwordController,
                              formKey: formKey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
