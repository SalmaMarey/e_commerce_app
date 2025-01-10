// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:e_commerce_app/core/services/di.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_event.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_state.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/products_list_widget.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/top_categories_widget.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/header_widget.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/offers_widget.dart';
import 'package:e_commerce_app/features/splash_onboarding/screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:e_commerce_app/core/models/user_model.dart';

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
      'electronics': 'assets/icons/elec_icon.png',
      'jewelery': 'assets/icons/clothing_icon.png',
      "men's clothing": 'assets/icons/home_icon.png',
      "women's clothing": 'assets/icons/books_icon.png',
    };

    return BlocProvider(
      create: (context) => di<HomeBloc>()..add(FetchCategoriesEvent()),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {},
        child: Scaffold(
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeLoaded || state is ProductsLoading) {
                final categories = (state is HomeLoaded)
                    ? state.categories
                    : (state as ProductsLoading).categories;
                final selectedCategory = (state is HomeLoaded)
                    ? state.selectedCategory
                    : (state as ProductsLoading).selectedCategory;

                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: HeaderWidget(
                        username: username,
                        onLogout: _logout,
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
                    TopCategoriesWidget(
                      categories: categories,
                      categoryImages: categoryImages,
                      selectedCategory: selectedCategory,
                    ),
                    // SliverToBoxAdapter(
                    //   child: Padding(
                    //     padding: EdgeInsets.only(top: 20.h, left: 20.w),
                    //     child: Text(
                    //       'Products',
                    //       style: AppTextStyles.font20Bold,
                    //     ),
                    //   ),
                    // ),
                    if (state is ProductsLoading)
                      const SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    if (state is HomeLoaded && state.products.isNotEmpty)
                      ProductsListWidget(products: state.products),
                  ],
                );
              } else if (state is HomeError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
