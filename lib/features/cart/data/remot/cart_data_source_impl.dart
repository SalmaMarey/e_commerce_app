import 'package:e_commerce_app/core/models/cart_model.dart';
import 'package:e_commerce_app/features/cart/data/remot/cart_data_source.dart';
import 'package:hive/hive.dart';

class CartLocalDataSourceImpl implements CartLocalDataSource {
  @override
  Future<void> addToCart(String userId, Cart cart) async {
    final cartBox = await Hive.openBox<Cart>('cartBox_$userId');
    await cartBox.add(cart);
  }

  @override
  Future<List<Cart>> getCartItems(String userId) async {
    final cartBox = await Hive.openBox<Cart>('cartBox_$userId');
    return cartBox.values.toList();
  }

  @override
  Future<void> removeFromCart(String userId, Cart cart) async {
    final cartBox = await Hive.openBox<Cart>('cartBox_$userId');
    await cartBox.delete(cart);
  }

  @override
  Future<void> updateCartItemQuantity(
      String userId, Cart cartItem, int newQuantity) async {
    final cartBox = await Hive.openBox<Cart>('cartBox_$userId');
    // final updatedCartItem = cartItem.copyWith(quantity: newQuantity);
    // await cartBox.put(cartItem.key, updatedCartItem);
  }
}
