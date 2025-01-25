import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const FavoriteProductItem({
    super.key,
    required this.product,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            errorWidget: (context, url, error) => const Center(
              child: Icon(Icons.error, size: 40),
            ),
          ),
          title: Text(
            product.title,
            maxLines: 1,
            style:
                AppTextStyles.font16Bold.copyWith(color: AppColors.textColor),
          ),
          subtitle: Text(
            '\$${product.price}',
            style: AppTextStyles.font14BoldBlack
                .copyWith(color: AppColors.primaryColor),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.favorite,
              color: AppColors.redColor,
            ),
            onPressed: onRemove,
          ),
        ),
      ),
    );
  }
}
