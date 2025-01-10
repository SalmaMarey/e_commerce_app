import 'package:e_commerce_app/core/models/product_model.dart';

abstract class HomeRepository {
  Future<List<String>> getCategories();
  Future<List<Product>> getProductsByCategory(String category);
}
