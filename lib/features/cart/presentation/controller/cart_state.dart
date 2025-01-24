import 'package:e_commerce_app/core/models/cart_model.dart';
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Cart>? cartItems;

  CartLoaded({this.cartItems});
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});
}