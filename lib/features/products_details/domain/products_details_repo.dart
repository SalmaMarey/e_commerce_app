import 'package:e_commerce_app/core/models/product_model.dart';

abstract class ProductDetailsRepository {
  Future<Product> getProductDetails(int productId);
}
