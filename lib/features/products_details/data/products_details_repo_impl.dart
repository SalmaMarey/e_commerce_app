import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/features/products_details/domain/products_details_repo.dart';
import 'remote/products_details_data_source.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final ProductDetailsDataSource productDetailsDataSource;

  ProductDetailsRepositoryImpl(this.productDetailsDataSource);

  @override
  Future<Product> getProductDetails(int productId) async {
    try {
      return await productDetailsDataSource.getProductDetails(productId);
    } catch (e) {
      throw Exception('Failed to fetch product details: $e');
    }
  }
}