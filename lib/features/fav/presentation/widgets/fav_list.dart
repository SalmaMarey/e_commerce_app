import 'package:e_commerce_app/core/error_handler/error_handler.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/services/di.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/features/fav/presentation/widgets/fav_product_item.dart';
import 'package:e_commerce_app/features/products_details/domain/usecases/get_products_details_usecase.dart';
import 'package:e_commerce_app/features/products_details/domain/usecases/toggle_favorite_usecase.dart';
import 'package:e_commerce_app/features/products_details/presentation/controller/products_details_bloc.dart';
import 'package:e_commerce_app/features/products_details/presentation/screens/products_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../products_details/domain/usecases/check_favorite_usecase.dart';

class FavoritesList extends StatelessWidget {
  final List<Product> favoriteProducts;
  final String userId;

  const FavoritesList({
    super.key,
    required this.favoriteProducts,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      itemCount: favoriteProducts.length,
      itemBuilder: (context, index) {
        final product = favoriteProducts[index];
        return FavoriteProductItem(
          product: product,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => ProductDetailsBloc(
                    getProductDetailsUseCase: di<GetProductDetailsUseCase>(),
                    toggleFavoriteUseCase: di<ToggleFavoriteUseCase>(
                      param1: userId,
                    ),
                    checkFavoriteUseCase: di<CheckFavoriteUseCase>(
                      param1: userId,
                    ),
                  ),
                  child: ProductDetailsScreen(productId: product.id),
                ),
              ),
            );
          },
          onRemove: () async {
            try {
              final favoritesBox = Hive.box<Product>('favoritesBox_$userId');
              await favoritesBox.delete(product.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Removed from favorites',
                    style: AppTextStyles.font16BoldPrimaryColor,
                  ),
                ),
              );
            } catch (error) {
              ErrorHandler.handleError(context, error);
            }
          },
        );
      },
    );
  }
}
