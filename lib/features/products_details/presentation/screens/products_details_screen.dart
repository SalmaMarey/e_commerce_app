import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/features/favorite/presentation/widgets/fav_icon.dart';
import 'package:e_commerce_app/features/products_details/presentation/controller/products_details_bloc.dart';
import 'package:e_commerce_app/features/products_details/presentation/controller/products_details_event.dart';
import 'package:e_commerce_app/features/products_details/presentation/controller/products_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<ProductDetailsBloc>()
        .add(FetchProductDetailsEvent(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductDetailsLoaded) {
            final product = state.product;
            return Scaffold(
              appBar: AppBar(
                title: Center(
                  child: Text(
                    'Products Details',
                    style: AppTextStyles.font20Bold,
                  ),
                ),
                leading: CircleAvatar(
                  radius: 25.r,
                  backgroundColor: AppColors.greyContainer,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                actions: [
                  CircleAvatar(
                    radius: 25.r,
                    backgroundColor: AppColors.greyContainer,
                    child: const FavoriteIcon(),
                  ),
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 35.h, right: 8.w, left: 8.w, bottom: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            CachedNetworkImage(
                              imageUrl: product.image,
                              height: 300.h,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                  size: 50,
                                ),
                              ),
                            ),
                            SizedBox(height: 36.h),
                            Text(
                              product.category,
                              style: AppTextStyles.font14Regular
                                  .copyWith(color: AppColors.grey0),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              product.title,
                              style: AppTextStyles.font22Bold,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              product.description,
                              style: AppTextStyles.font14Regular
                                  .copyWith(color: AppColors.grey0),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10.h),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                  color: AppColors.greyContainer,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: AppColors.primaryColor,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          '4.6/5',
                                          style: AppTextStyles.font16Bold
                                              .copyWith(
                                                  color: AppColors.textColor),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Icon(
                                          Icons.auto_awesome_motion_outlined,
                                          color: AppColors.primaryColor,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          'Comfort',
                                          style: AppTextStyles.font16Bold
                                              .copyWith(
                                                  color: AppColors.textColor),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Icon(
                                          Icons.done_all,
                                          color: AppColors.primaryColor,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          'Durable',
                                          style: AppTextStyles.font16Bold
                                              .copyWith(
                                                  color: AppColors.textColor),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Icon(
                                          Icons.verified_user,
                                          color: AppColors.primaryColor,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          'Adaptive',
                                          style: AppTextStyles.font16Bold
                                              .copyWith(
                                                  color: AppColors.textColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.textColor,
                        minimumSize: Size(double.infinity, 60.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add to Cart',
                            style: AppTextStyles.font16Bold
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            '\$${product.price}',
                            style: AppTextStyles.font16Bold
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProductDetailsError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
