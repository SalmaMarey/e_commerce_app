import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/themes/app_colors.dart';
import 'package:e_commerce_app/core/themes/app_text_styles.dart';
import 'package:e_commerce_app/features/cart/presentation/controller/cart_bloc.dart';
import 'package:e_commerce_app/features/cart/presentation/controller/cart_event.dart';
import 'package:e_commerce_app/features/cart/presentation/controller/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    context.read<CartBloc>().add(GetCartItemsEvent());
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
      body: BlocBuilder<CartBloc, CartState>(
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
                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      style: AppTextStyles.font16Bold
                          .copyWith(color: AppColors.textColor),
                    ),
                    subtitle: Text(
                      '\$${cartItem.price}',
                      style: AppTextStyles.font14BoldBlack
                          .copyWith(color: AppColors.primaryColor),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // IconButton(
                        //   icon: Icon(Icons.remove, color: Colors.red),
                        //   onPressed: () {
                        //     _updateQuantity(context, cartItem, cartItem.quantity - 1);
                        //   },
                        // ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '${cartItem.quantity}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        // IconButton(
                        //   icon: Icon(Icons.add, color: Colors.green),
                        //   onPressed: () {
                        //     _updateQuantity(context, cartItem, cartItem.quantity + 1);
                        //   },
                        // ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }

// void _updateQuantity(BuildContext context, Cart cartItem, int newQuantity) {
//   if (newQuantity > 0) {
//     context.read<CartBloc>().add(UpdateCartItemQuantityEvent(
//           cartItem: cartItem,
//           newQuantity: newQuantity,
//         ));
//   } else {
//     context.read<CartBloc>().add(RemoveFromCartEvent(cart: cartItem)); // Pass 'cart: cartItem'
//   }
// }
}
