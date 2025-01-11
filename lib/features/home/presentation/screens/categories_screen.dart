import 'package:e_commerce_app/core/services/di.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/assets.dart';
import 'package:e_commerce_app/features/home/presentation/screens/all_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_event.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final Map<String, String> categoryImages = {
    'electronics': Assets.elecIcon,
    'jewelery': Assets.jeweleryIcon,
    "men's clothing": Assets.mensIcon,
    "women's clothing": Assets.womenIcon,
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<HomeBloc>(),
      child: Builder(
        builder: (context) {
          return _CategoriesScreenContent(
            categoryImages: categoryImages,
            homeBloc: context.read<HomeBloc>(),
          );
        },
      ),
    );
  }
}

class _CategoriesScreenContent extends StatefulWidget {
  final Map<String, String> categoryImages;
  final HomeBloc homeBloc;

  const _CategoriesScreenContent({
    required this.categoryImages,
    required this.homeBloc,
  });

  @override
  State<_CategoriesScreenContent> createState() =>
      _CategoriesScreenContentState();
}

class _CategoriesScreenContentState extends State<_CategoriesScreenContent> {
  @override
  void initState() {
    super.initState();
    widget.homeBloc.add(FetchCategoriesEvent());
  }

  String formatCategoryName(String text) {
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: AppTextStyles.font20Bold,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: widget.homeBloc,
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            final categories = state.categories;
            return GridView.builder(
              padding: EdgeInsets.all(16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: 1.5,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final imagePath =
                    widget.categoryImages[category] ?? Assets.errorImage;
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: widget.homeBloc,
                            child: AllProductsScreen(category: category),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          imagePath,
                          width: 60.w,
                          height: 60.h,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.category, size: 60);
                          },
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          formatCategoryName(category),
                          style: AppTextStyles.font16BoldPrimaryColor,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is HomeError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No categories available'));
          }
        },
      ),
    );
  }
}
