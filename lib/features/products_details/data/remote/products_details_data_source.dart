import 'package:e_commerce_app/core/models/product_model.dart';

abstract class ProductDetailsDataSource {
  Future<Product> getProductDetails(int productId);
}
