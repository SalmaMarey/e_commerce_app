// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_event.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_state.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/offers_widget.dart';
import 'package:e_commerce_app/features/splash_onboarding/screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final Map<String, String> categoryImages = {
      'Electronics': 'assets/icons/elec_icon.png',
      'Clothing': 'assets/icons/clothing_icon.png',
      'Home': 'assets/icons/home_icon.png',
      'Books': 'assets/icons/books_icon.png',
    };

    return BlocProvider(
      create: (context) => HomeBloc()..add(FetchCategoriesEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 58.h, left: 23.w, right: 21.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            IconButton(
                              icon: const Icon(Icons.logout,
                                  color: AppColors.primaryColor),
                              onPressed: _logout,
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
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: SizedBox(
                      height: 150.h,
                      child: const OffersWidget(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h, left: 20.w),
                    child: Text(
                      'Top Categories',
                      style: AppTextStyles.font20Bold,
                    ),
                  ),
                ),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final category = state.categories[index];
                      final imagePath = categoryImages[category] ??
                          "assets/images/error_image.png";

                      return InkWell(
                        onTap: () {
                          context.read<HomeBloc>().add(
                                SelectCategoryEvent(category),
                              );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              imagePath,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 8),
                            // Text(category),
                          ],
                        ),
                      );
                    },
                    childCount: state.categories.length,
                  ),
                ),
              ],
            );
          } else if (state is CategorySelected) {
            return Center(
              child: Text('Selected Category: ${state.selectedCategory}'),
            );
          } else if (state is HomeError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
