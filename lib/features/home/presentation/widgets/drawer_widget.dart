import 'package:cached_network_image/cached_network_image.dart'; 
import 'package:e_commerce_app/core/services/di.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/screens/categories_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerWidget extends StatelessWidget {
  final VoidCallback onLogout;
  final String uid;
  final String? username;
  final String? userPhotoUrl;
  const DrawerWidget({
    super.key,
    required this.onLogout,
    required this.uid,
    this.username,
    this.userPhotoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: userPhotoUrl ?? Assets.errorImage,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 30.r,
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context, url) => CircleAvatar(
                    radius: 30.r,
                    child: const CircularProgressIndicator(
                      color: AppColors.scaffoldBackgroundLightColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: 30.r,
                    child: const Icon(Icons.person, size: 40),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Hello, ${username ?? 'Guest'}',
                  style: AppTextStyles.font20Bold.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.category_outlined,
                    color: AppColors.primaryColor),
                title: Text('Categories',
                    style: AppTextStyles.font16BoldPrimaryColor),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => di<HomeBloc>(),
                        child: const CategoriesScreen(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined,
                color: AppColors.primaryColor),
            title:
                Text('Settings', style: AppTextStyles.font16BoldPrimaryColor),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.share_outlined, color: AppColors.primaryColor),
            title: Text('Tell a Friend',
                style: AppTextStyles.font16BoldPrimaryColor),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.help_outline, color: AppColors.primaryColor),
            title: Text('Help and Feedback',
                style: AppTextStyles.font16BoldPrimaryColor),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.primaryColor),
            title: Text('Log Out', style: AppTextStyles.font16BoldPrimaryColor),
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
}
