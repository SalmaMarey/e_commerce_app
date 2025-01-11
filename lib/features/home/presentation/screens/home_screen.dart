// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:e_commerce_app/core/services/di.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/assets.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_event.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_state.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/drawer_widget.dart';
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
  String? userPhotoUrl; // Add user photo URL
  late Box<UserModel> userBox;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _fetchUserDataFromHive();
  }

  void _fetchUserDataFromHive() async {
    try {
      userBox = await Hive.openBox<UserModel>('userBox');
      final userModel = userBox.values.first;

      setState(() {
        username = userModel.userName;
        userPhotoUrl = userModel.imageUrl; // Fetch user photo URL from Hive
      });
    } catch (e) {
      print('Error fetching user from Hive: $e');
      setState(() {
        username = 'Guest';
        userPhotoUrl = null; // Set photo URL to null if not available
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
      'electronics': Assets.elecIcon,
      'jewelery': Assets.jeweleryIcon,
      "men's clothing": Assets.circleShape,
      "women's clothing": Assets.womenIcon,
    };
    return BlocProvider(
      create: (context) => di<HomeBloc>()..add(FetchCategoriesEvent()),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {},
        child: Scaffold(
          key: _scaffoldKey,
          drawer: DrawerWidget(
            onLogout: _logout,
            uid: username ?? 'Guest',
            username: username, // Pass username to DrawerWidget
            userPhotoUrl: userPhotoUrl, // Pass user photo URL to DrawerWidget
          ),
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
                        scaffoldKey: _scaffoldKey,
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
                        padding: EdgeInsets.only(
                          top: 20.h,
                          left: 20.w,
                        ),
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
                    if (state is ProductsLoading)
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 350,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
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