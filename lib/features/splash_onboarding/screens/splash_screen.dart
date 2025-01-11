// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_app/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:e_commerce_app/core/models/user_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 0));
    final isLoggedIn = await _isUserLoggedIn();
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/layout');
    } else {
      Navigator.pushReplacementNamed(context, '/start');
    }
  }

  Future<bool> _isUserLoggedIn() async {
    final userBox = Hive.box<UserModel>('userBox');
    return userBox.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(Assets.logoApp,width: 120.w,height: 120.h,)),
    );
  }
}
