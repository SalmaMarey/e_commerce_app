import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/features/products_details/presentation/controller/products_details_bloc.dart';
import 'package:e_commerce_app/features/products_details/presentation/controller/products_details_event.dart';
import 'package:e_commerce_app/features/products_details/presentation/controller/products_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteIcon extends StatefulWidget {
  final Product product;

  const FavoriteIcon({super.key, required this.product});

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        final isFavorited =
            state is ProductDetailsLoaded ? state.isFavorited : false;

        return GestureDetector(
          onTap: () {
            context.read<ProductDetailsBloc>().add(ToggleFavoriteEvent());
          },
          child: Icon(
            isFavorited ? Icons.favorite : Icons.favorite_outline,
            size: 24.r,
            color: isFavorited ? AppColors.redColor: AppColors.primaryColor,
          ),
        );
      },
    );
  }
}
