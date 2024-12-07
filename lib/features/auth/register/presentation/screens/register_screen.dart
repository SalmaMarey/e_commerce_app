import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/assets.dart';
import 'package:e_commerce_app/features/auth/register/data/remote/user_data_source_impl.dart';
import 'package:e_commerce_app/features/auth/register/data/user_repo_impl.dart';
import 'package:e_commerce_app/features/auth/register/presentation/bloc/register_bloc.dart';
import 'package:e_commerce_app/features/auth/register/presentation/bloc/register_event.dart';
import 'package:e_commerce_app/features/auth/register/presentation/bloc/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => UserBloc(
          UserRepositoryImpl(UserDataSourceImpl(FirebaseFirestore.instance)),
        ),
        child: BlocConsumer<UserBloc, UserState>(listener: (context, state) {
          if (state is UserSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('User saved!')));
          } else if (state is UserFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        }, builder: (context, state) {
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
                            controller: _emailController,
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
                            controller: _passwordController,
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
                            controller: _phoneController,
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
                              final user = UserModel(
                                id: DateTime.now()
                                    .toString(),
                                email: _emailController.text,
                                password: _passwordController.text,
                                phoneNumber: _phoneController.text,
                              );
                              context.read<UserBloc>().add(SaveUserEvent(user));
                            },
                            child: state is UserLoading
                                ? CircularProgressIndicator()
                                : const Text('Done'),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, Routes.login);
                            },
                            child: Text(
                              'Cancel',
                              style: AppTextStyles.font15Medium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
