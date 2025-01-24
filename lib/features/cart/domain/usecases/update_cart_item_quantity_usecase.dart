import 'package:e_commerce_app/core/models/cart_model.dart';
import 'package:e_commerce_app/features/cart/domain/cart_repo.dart';

class UpdateCartItemQuantityUseCase {
  final CartRepository repository;

  UpdateCartItemQuantityUseCase({required this.repository});

  Future<void> execute(String userId, Cart cartItem, int newQuantity) async {
    await repository.updateCartItemQuantity(userId, cartItem, newQuantity);
  }
}