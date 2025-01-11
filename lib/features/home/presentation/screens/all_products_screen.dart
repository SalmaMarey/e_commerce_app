import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/fav_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_event.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AllProductsScreen extends StatefulWidget {
  final String category;

  const AllProductsScreen({super.key, required this.category});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchProductsByCategoryEvent(widget.category));
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          capitalizeFirstLetter(widget.category),
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
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded && state.products.isNotEmpty) {
            final products = state.products;
            return GridView.builder(
              padding: EdgeInsets.all(16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: 0.8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Stack(
                    children: [
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
                      Positioned(
                        top: 8.h,
                        right: 8.w,
                        child: const FavoriteIcon(),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is HomeError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No products available'));
          }
        },
      ),
    );
  }
}
