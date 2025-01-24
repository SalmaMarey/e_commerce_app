import 'package:e_commerce_app/core/models/cart_model.dart';
import 'package:e_commerce_app/features/cart/data/remot/cart_data_source.dart';
import 'package:e_commerce_app/features/cart/domain/cart_repo.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addToCart(String userId, Cart cart) async {
    await localDataSource.addToCart(userId, cart);
  }

  @override
  Future<List<Cart>> getCartItems(String userId) async {
    return await localDataSource.getCartItems(userId);
  }

  @override
  Future<void> removeFromCart(String userId, Cart cart) async {
    await localDataSource.removeFromCart(userId, cart);
  }

  @override
  Future<void> updateCartItemQuantity(
      String userId, Cart cartItem, int newQuantity) async {
    await localDataSource.updateCartItemQuantity(userId, cartItem, newQuantity);
  }
}
