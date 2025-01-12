import 'package:e_commerce_app/features/products_details/presentation/controller/products_details_bloc.dart';
import 'package:e_commerce_app/features/products_details/presentation/controller/products_details_event.dart';
import 'package:e_commerce_app/features/products_details/presentation/controller/products_details_state.dart';
import 'package:e_commerce_app/features/products_details/presentation/widgets/add_to_cart_button.dart';
import 'package:e_commerce_app/features/products_details/presentation/widgets/product_detail_widget.dart';
import 'package:e_commerce_app/features/products_details/presentation/widgets/product_feature.dart';
import 'package:e_commerce_app/features/products_details/presentation/widgets/product_image.dart';
import 'package:e_commerce_app/features/products_details/presentation/widgets/products_details_appbar.dart';
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
              appBar: const ProductDetailsAppBar(),
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
                            SizedBox(height: 20.h),
                            ProductImage(imageUrl: product.image),
                            ProductDetails(
                              category: product.category,
                              title: product.title,
                              description: product.description,
                            ),
                            SizedBox(height: 10.h),
                            const ProductFeatures(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AddToCartButton(price: product.price),
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
