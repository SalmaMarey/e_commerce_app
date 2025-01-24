import 'package:e_commerce_app/core/models/cart_model.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/features/cart/presentation/controller/cart_bloc.dart';
import 'package:e_commerce_app/features/cart/presentation/controller/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddToCartButton extends StatelessWidget {
  final double price;
  final Product product;
  final String userId;

  const AddToCartButton({
    super.key,
    required this.price,
    required this.product,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.read<CartBloc>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: ElevatedButton(
        onPressed: () {
          final cart = Cart(
            productId: product.id,
            productName: product.title,
            price: product.price,
            imageUrl: product.image,
            quantity: 1, 
          );
          cartBloc.add(AddToCartEvent(cart: cart));
        },
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
              style: AppTextStyles.font16Bold.copyWith(color: Colors.white),
            ),
            Text(
              '\$$price',
              style: AppTextStyles.font16Bold.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}