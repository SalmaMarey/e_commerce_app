import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/error_handler/error_handler.dart';
import 'package:e_commerce_app/core/models/cart_model.dart';
import 'package:e_commerce_app/core/services/di.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/features/cart/presentation/controller/cart_bloc.dart';
import 'package:e_commerce_app/features/cart/presentation/controller/cart_event.dart';
import 'package:e_commerce_app/features/cart/presentation/controller/cart_state.dart';
import 'package:e_commerce_app/features/products_details/domain/usecases/check_favorite_usecase.dart';
import 'package:e_commerce_app/features/products_details/domain/usecases/get_products_details_usecase.dart';
import 'package:e_commerce_app/features/products_details/domain/usecases/toggle_favorite_usecase.dart';
import 'package:e_commerce_app/features/products_details/presentation/controller/products_details_bloc.dart';
import 'package:e_commerce_app/features/products_details/presentation/screens/products_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  final String userId;

  const CartScreen({super.key, required this.userId});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  void _loadCartItems() async {
    try {
      context.read<CartBloc>().add(GetCartItemsEvent());
    } catch (error) {
      ErrorHandler.handleError(context, error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'My Cart',
            style: AppTextStyles.font22Bold
                .copyWith(color: AppColors.primaryColor),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartError) {
            ErrorHandler.handleError(context, state.message);
          }
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              final cartItems = state.cartItems ?? [];
              if (cartItems.isEmpty) {
                return const Center(child: Text('Your cart is empty'));
              }
              return ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartItems[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => ProductDetailsBloc(
                              getProductDetailsUseCase:
                                  di<GetProductDetailsUseCase>(),
                              toggleFavoriteUseCase: di<ToggleFavoriteUseCase>(
                                  param1: widget.userId),
                              checkFavoriteUseCase: di<CheckFavoriteUseCase>(
                                  param1: widget.userId),
                            ),
                            child: ProductDetailsScreen(
                              productId: cartItem.productId,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: cartItem.imageUrl,
                          width: 60,
                          height: 60,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        title: Text(
                          cartItem.productName,
                          maxLines: 1,
                          style: AppTextStyles.font16Bold.copyWith(
                            color: AppColors.textColor,
                          ),
                        ),
                        subtitle: Text(
                          '\$${cartItem.price}',
                          style: AppTextStyles.font14BoldBlack.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        trailing: SizedBox(
                          width: 120.w,
                          height: 30.h,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(color: AppColors.primaryColor),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove,
                                    color: AppColors.primaryColor,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    _updateQuantity(context, cartItem,
                                        cartItem.quantity - 1);
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                                Text(
                                  '${cartItem.quantity}',
                                  style: AppTextStyles.font16Bold.copyWith(
                                    color: AppColors.textColor,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    color: AppColors.primaryColor,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    _updateQuantity(context, cartItem,
                                        cartItem.quantity + 1);
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: Text('Something went wrong'));
          },
        ),
      ),
    );
  }

  void _updateQuantity(BuildContext context, Cart cartItem, int newQuantity) {
    try {
      if (newQuantity > 0) {
        context.read<CartBloc>().add(
              UpdateCartItemQuantityEvent(
                cartItem: cartItem,
                newQuantity: newQuantity,
              ),
            );
      } else {
        context.read<CartBloc>().add(
              RemoveFromCartEvent(cart: cartItem),
            );
      }
    } catch (error) {
      ErrorHandler.handleError(context, error);
    }
  }
}