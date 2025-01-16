// ignore_for_file: avoid_print

import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:hive/hive.dart';

class ToggleFavoriteUseCase {
  final Box<Product> favoritesBox;

  ToggleFavoriteUseCase(this.favoritesBox);

  Future<void> call(Product product) async {
    product.isFavorite = !product.isFavorite;
    if (product.isFavorite) {
      await favoritesBox.put(product.id, product);
    } else {
      await favoritesBox.delete(product.id);
    }
    print('Product ${product.id} isFavorite: ${product.isFavorite}');
  }
}
