// ignore_for_file: avoid_print

import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:hive/hive.dart';

class ToggleFavoriteUseCase {
  final String userId;

  ToggleFavoriteUseCase(this.userId);

  Future<void> call(Product product) async {
    final favoritesBox = await Hive.openBox<Product>('favoritesBox_$userId');
    product.isFavorite = !product.isFavorite;
    if (product.isFavorite) {
      await favoritesBox.put(product.id, product);
    } else {
      await favoritesBox.delete(product.id);
    }
    print('Product ${product.id} isFavorite: ${product.isFavorite}');
  }
}
