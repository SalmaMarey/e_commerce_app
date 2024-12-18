import 'package:e_commerce_app/core/utils/hive_keys.dart';
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
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    await HiveKeys.initializeHive();
    userBox = Hive.box<UserModel>(HiveKeys.userBox);
    _fetchUsernameFromHive();
  }

  void _fetchUsernameFromHive() {
    final userModel = userBox.get('user_id');

    if (userModel != null) {
      setState(() {
        username = userModel.userName;
      });
    } else {
      setState(() {
        username = 'Guest';
      });
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundColor: AppColors.textForm,
                      child: const Icon(
                        Icons.list,
                        size: 30,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundColor: AppColors.textForm,
                      child: const Icon(
                        Icons.search,
                        size: 30,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              username == null
                  ? const CircularProgressIndicator()
                  : Text(
                      'Hello, ${username ?? 'Guest'}!',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
