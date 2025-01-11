import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/assets.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopCategoriesWidget extends StatelessWidget {
  final List<String> categories;
  final Map<String, String> categoryImages;
  final String? selectedCategory;

  const TopCategoriesWidget({
    super.key,
    required this.categories,
    required this.categoryImages,
    this.selectedCategory,
  });

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  String modifyCategoryName(int index, String category) {
    if (index == 2) {
      return "Men's Wear";
    } else if (index == 3) {
      return "Women's Wear";
    }
    return category;
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 5,
        crossAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final category = categories[index];
          final imagePath =
              categoryImages[category] ?? Assets.errorImage;
          final isSelected = category == selectedCategory;

          final displayedCategory = modifyCategoryName(index, category);

          return InkWell(
            onTap: () {
              context
                  .read<HomeBloc>()
                  .add(FetchProductsByCategoryEvent(category));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? AppColors.primaryColor
                        : Colors.transparent,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    imagePath,
                    width: 40.w,
                    height: 40.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  capitalizeFirstLetter(displayedCategory),
                  style: isSelected
                      ? AppTextStyles.font14Regular
                      : AppTextStyles.font14RegularBlack,
                ),
              ],
            ),
          );
        },
        childCount: categories.length,
      ),
    );
  }
}
