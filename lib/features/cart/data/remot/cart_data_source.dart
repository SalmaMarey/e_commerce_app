import 'package:e_commerce_app/core/models/cart_model.dart';

abstract class CartLocalDataSource {
  Future<void> addToCart(String userId, Cart cart);
  Future<List<Cart>> getCartItems(String userId);
  Future<void> removeFromCart(String userId, Cart cart);
  Future<void> updateCartItemQuantity(
      String userId, Cart cartItem, int newQuantity);
}
