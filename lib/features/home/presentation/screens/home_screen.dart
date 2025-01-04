// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:e_commerce_app/features/splash_onboarding/screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:e_commerce_app/core/models/user_model.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  late Box<UserModel> userBox;

  @override
  void initState() {
    super.initState();
    _fetchUsernameFromHive();
  }

  void _fetchUsernameFromHive() async {
    try {
      userBox = await Hive.openBox<UserModel>('userBox');
      final userModel = userBox.values.first;

      setState(() {
        username = userModel.userName;
      });
    } catch (e) {
      print('Error fetching user from Hive: $e');
      setState(() {
        username = 'Guest';
      });
    }
  }

  void _logout() async {
    try {
      await userBox.clear();
      print('User logged out and data cleared from Hive.');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const StartScreen()),
      );
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 58.h, left: 23.w, right: 21.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              username == null
                  ? const CircularProgressIndicator()
                  : Text(
                      'Hello, ${username ?? 'Guest'}!',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),  IconButton(
            icon: const Icon(Icons.logout, color: AppColors.primaryColor),
            onPressed: _logout,
          ),
            ],
          ),
        ),
      ),
    );
  }
}
