import 'package:e_commerce_app/core/models/cart_model.dart';

abstract class CartRepository {
  Future<bool> addToCart(String userId, Cart cart);
  Future<List<Cart>> getCartItems(String userId);
  Future<void> updateCartItemQuantity(
      String userId, Cart cartItem, int newQuantity);
  Future<void> removeFromCart(String userId, Cart cart);
}
