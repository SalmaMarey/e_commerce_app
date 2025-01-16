import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/services/di.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
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
        crossAxisSpacing: 1,
        mainAxisSpacing: 10,
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
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: CachedNetworkImage(
                                      imageUrl: product.image,
                                      width: 120.w,
                                      height: 120.h,
                                      placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Center(
                                        child: Icon(Icons.error, size: 40),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 4.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title,
                                      style: AppTextStyles.font14Bold
                                          .copyWith(color: AppColors.textColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 2.h),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '\$${product.price.toStringAsFixed(2)}',
                                        style: AppTextStyles.font14Bold,
                                      ),
                                    ),
                                  ],
                                ),
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
