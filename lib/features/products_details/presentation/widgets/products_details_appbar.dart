import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/features/products_details/presentation/widgets/fav_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Product product;

  const ProductDetailsAppBar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
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
          child: FavoriteIcon(product: product),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
