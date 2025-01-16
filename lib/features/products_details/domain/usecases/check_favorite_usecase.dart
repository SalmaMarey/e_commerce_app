import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:hive/hive.dart';

class CheckFavoriteUseCase {
  final Box<Product> favoritesBox;

  CheckFavoriteUseCase(this.favoritesBox);

  bool call(Product product) {
    return favoritesBox.containsKey(product.id); 
  }
}