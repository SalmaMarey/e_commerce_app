import 'package:e_commerce_app/core/models/cart_model.dart';
import 'package:e_commerce_app/features/cart/domain/cart_repo.dart';

class GetCartItemsUseCase {
  final CartRepository repository;

  GetCartItemsUseCase({required this.repository});

  Future<List<Cart>> execute(String userId) async {
    return await repository.getCartItems(userId);
  }
}
