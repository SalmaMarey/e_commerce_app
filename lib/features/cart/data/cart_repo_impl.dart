import 'package:e_commerce_app/core/models/cart_model.dart';
import 'package:e_commerce_app/features/cart/data/remot/cart_data_source.dart';
import 'package:e_commerce_app/features/cart/domain/cart_repo.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<bool> addToCart(String userId, Cart cart) async {
    try {
      await localDataSource.addToCart(userId, cart);
      return true; 
    } catch (e) {
      return false; 
    }
  }

  @override
  Future<List<Cart>> getCartItems(String userId) async {
    return await localDataSource.getCartItems(userId);
  }

  @override
  Future<void> updateCartItemQuantity(String userId, Cart cartItem, int newQuantity) async {
    await localDataSource.updateCartItemQuantity(userId, cartItem, newQuantity);
  }

  @override
  Future<void> removeFromCart(String userId, Cart cart) async {
    await localDataSource.removeFromCart(userId, cart);
  }
}