import 'package:e_commerce_app/features/home/presentation/controller/home_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopCategoriesWidget extends StatelessWidget {
  final List<String> categories;
  final Map<String, String> categoryImages;

  const TopCategoriesWidget(
      {super.key, required this.categories, required this.categoryImages});

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
              categoryImages[category] ?? "assets/images/error_image.png";

          return InkWell(
            onTap: () {
              context
                  .read<HomeBloc>()
                  .add(FetchProductsByCategoryEvent(category));
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
                Text(category),
              ],
            ),
          );
        },
        childCount: categories.length,
      ),
    );
  }
}
