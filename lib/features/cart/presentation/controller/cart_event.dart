import 'package:e_commerce_app/core/models/cart_model.dart';

abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final Cart cart;

  AddToCartEvent({required this.cart});
}

class GetCartItemsEvent extends CartEvent {}
class RemoveFromCartEvent extends CartEvent {
  final Cart cart; 

  RemoveFromCartEvent({required this.cart}); 
}
class UpdateCartItemQuantityEvent extends CartEvent {
  final Cart cartItem;
  final int newQuantity;

  UpdateCartItemQuantityEvent({
    required this.cartItem,
    required this.newQuantity,
  });
}
