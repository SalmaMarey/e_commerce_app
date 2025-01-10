import 'package:e_commerce_app/features/home/presentation/controller/home_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopCategoriesWidget extends StatelessWidget {
  final List<String> categories;
  final Map<String, String> categoryImages;
  final String? selectedCategory; // Add this property

  const TopCategoriesWidget({
    super.key,
    required this.categories,
    required this.categoryImages,
    this.selectedCategory, // Initialize with null
  });

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
          final imagePath = categoryImages[category] ?? "assets/images/error_image.png";
          final isSelected = category == selectedCategory; // Check if the category is selected

          return InkWell(
            onTap: () {
              context.read<HomeBloc>().add(FetchProductsByCategoryEvent(category));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? Colors.blue : Colors.transparent, // Highlight if selected
                  ),
                  padding: const EdgeInsets.all(8), // Add padding for the circle
                  child: Image.asset(
                    imagePath,
                    width: 40, // Adjust size to fit inside the circle
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.blue : Colors.black, // Highlight text if selected
                  ),
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