import 'package:e_commerce_app/core/models/product_model.dart';

abstract class HomeDataSource {
  Future<List<String>> getCategories();
  Future<List<Product>> getProductsByCategory(String category);
}
