import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:e_commerce_app/features/home/presentation/controller/home_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_event.dart';

class HeaderWidget extends StatelessWidget {
  final String? username;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final HomeBloc homeBloc;

  const HeaderWidget({
    super.key,
    required this.username,
    required this.scaffoldKey,
    required this.homeBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 58.h, left: 23.w, right: 21.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  scaffoldKey.currentState?.openDrawer();
                },
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
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TextField(
                    onChanged: (query) {
                      homeBloc.add(SearchProductsEvent(query));
                    },
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.textForm,
                      prefixIcon: const Icon(Icons.search,
                          color: AppColors.primaryColor),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          username == null
              ? const CircularProgressIndicator()
              : Text(
                  'Hello, ${username ?? 'Guest'}!',
                  style: AppTextStyles.font20Bold,
                ),
          Text(
            'Let’s start shopping!',
            style: AppTextStyles.font16BoldGrey,
          ),
        ],
      ),
    );
  }
}
