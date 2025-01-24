import 'package:e_commerce_app/core/models/cart_model.dart';
import 'package:e_commerce_app/features/cart/domain/cart_repo.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase({required this.repository});

  Future<void> execute(String userId, Cart cart) async {
    await repository.addToCart(userId, cart);
  }
}
