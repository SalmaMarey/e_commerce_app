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
  Future<void> updateCartItemQuantity(
      String userId, Cart cartItem, int newQuantity) async {
    final cartBox = await Hive.openBox<Cart>('cartBox_$userId');
    final index = cartBox.values
        .toList()
        .indexWhere((item) => item.productId == cartItem.productId);
    if (index != -1) {
      final updatedCartItem = Cart(
        productId: cartItem.productId,
        productName: cartItem.productName,
        price: cartItem.price,
        imageUrl: cartItem.imageUrl,
        quantity: newQuantity,
      );
      await cartBox.putAt(index, updatedCartItem);
    }
  }

  @override
  Future<void> removeFromCart(String userId, Cart cart) async {
    final cartBox = await Hive.openBox<Cart>('cartBox_$userId');
    final index = cartBox.values
        .toList()
        .indexWhere((item) => item.productId == cart.productId);
    if (index != -1) {
      await cartBox.deleteAt(index);
    }
  }
}
