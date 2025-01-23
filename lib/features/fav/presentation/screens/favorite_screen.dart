// ignore_for_file: avoid_print, use_build_context_synchronously
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/services/di.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/features/products_details/domain/usecases/check_favorite_usecase.dart';
import 'package:e_commerce_app/features/products_details/domain/usecases/get_products_details_usecase.dart';
import 'package:e_commerce_app/features/products_details/domain/usecases/toggle_favorite_usecase.dart';
import 'package:e_commerce_app/features/products_details/presentation/screens/products_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../products_details/presentation/controller/products_details_bloc.dart';

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
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final favoritesBox = Hive.box<Product>('favoritesBox_$userId');
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Favorites',
                style: AppTextStyles.font22Bold
                    .copyWith(color: AppColors.primaryColor),
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
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 16.w),
                        itemCount: favoriteProducts.length,
                        itemBuilder: (context, index) {
                          final product = favoriteProducts[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => ProductDetailsBloc(
                                      getProductDetailsUseCase:
                                          di<GetProductDetailsUseCase>(),
                                      toggleFavoriteUseCase:
                                          di<ToggleFavoriteUseCase>(
                                              param1: userId),
                                      checkFavoriteUseCase:
                                          di<CheckFavoriteUseCase>(
                                              param1: userId),
                                    ),
                                    child: ProductDetailsScreen(
                                        productId: product.id),
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 4,
                              margin: EdgeInsets.only(bottom: 16.h),
                              child: ListTile(
                                leading: CachedNetworkImage(
                                  imageUrl: product.image,
                                  width: 70.w,
                                  height: 70.h,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Center(
                                    child: Icon(Icons.error, size: 40),
                                  ),
                                ),
                                title: Text(
                                  product.title,
                                  maxLines: 1,
                                  style: AppTextStyles.font14Bold
                                      .copyWith(color: AppColors.textColor),
                                ),
                                subtitle: Text(
                                  '\$${product.price}',
                                  style: AppTextStyles.font14Regular,
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: AppColors.redColor,
                                  ),
                                  onPressed: () async {
                                    await favoritesBox.delete(product.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Removed from favorites'),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          );
        }
      },
    );
  }
}
