import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/services/di.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/fav_icon.dart';
import 'package:e_commerce_app/features/products_details/presentation/controller/products_details_bloc.dart';
import 'package:e_commerce_app/features/products_details/presentation/screens/products_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsListWidget extends StatelessWidget {
  final List<Product> products;

  const ProductsListWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.92,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => di<ProductDetailsBloc>(),
                    child: ProductDetailsScreen(productId: product.id),
                  ),
                ),
              );
            },
            child: Container(
              width: 174.w,
              decoration: BoxDecoration(
                color: AppColors.greyContainer,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CachedNetworkImage(
                            imageUrl: product.image,
                            width: 120.w,
                            height: 120.h,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 40.w,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: AppTextStyles.font14BoldBlack,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox.shrink(),
                                  Text(
                                    '\$${product.price}',
                                    style: AppTextStyles.font16BoldPrimaryColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Positioned(
                      top: 0,
                      right: 0,
                      child: FavoriteIcon(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        childCount: products.length,
      ),
    );
  }
}
