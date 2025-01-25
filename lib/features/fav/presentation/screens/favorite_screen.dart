// ignore_for_file: avoid_print, use_build_context_synchronously
import 'package:e_commerce_app/core/error_handler/error_handler.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/features/fav/presentation/widgets/fav_list.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesScreen extends StatelessWidget {
  final String userId;

  const FavoritesScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox<Product>('favoritesBox_$userId'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          ErrorHandler.handleError(context, snapshot.error!);
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final favoritesBox = Hive.box<Product>('favoritesBox_$userId');
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  'Favorites',
                  style: AppTextStyles.font22Bold
                      .copyWith(color: AppColors.primaryColor),
                ),
              ),
              automaticallyImplyLeading: false,
            ),
            body: ValueListenableBuilder(
              valueListenable: favoritesBox.listenable(),
              builder: (context, Box<Product> box, _) {
                final favoriteProducts = box.values.toList();
                return favoriteProducts.isEmpty
                    ? Center(
                        child: Text(
                          'No favorites yet!',
                          style: AppTextStyles.font16BoldPrimaryColor,
                        ),
                      )
                    : FavoritesList(
                        favoriteProducts: favoriteProducts,
                        userId: userId,
                      );
              },
            ),
          );
        }
      },
    );
  }
}
