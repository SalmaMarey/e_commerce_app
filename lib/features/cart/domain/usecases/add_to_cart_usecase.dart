import 'package:e_commerce_app/core/models/cart_model.dart';
import 'package:e_commerce_app/features/cart/domain/cart_repo.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase({required this.repository});

  Future<bool> execute(String userId, Cart cart) async {
    return await repository.addToCart(userId, cart);
  }
}