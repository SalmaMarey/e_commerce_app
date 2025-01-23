import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:hive/hive.dart';

class CheckFavoriteUseCase {
  final String userId;

  CheckFavoriteUseCase(this.userId);

  Future<bool> call(Product product) async {
    final favoritesBox = await Hive.openBox<Product>('favoritesBox_$userId');
    return favoritesBox.containsKey(product.id);
  }
}
