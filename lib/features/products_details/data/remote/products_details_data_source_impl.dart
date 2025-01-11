import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/features/products_details/data/remote/products_details_data_source.dart';

class ProductDetailsDataSourceImpl implements ProductDetailsDataSource {
  final Dio dio;

  ProductDetailsDataSourceImpl(this.dio);

  @override
  Future<Product> getProductDetails(int productId) async {
    try {
      final response =
          await dio.get('https://fakestoreapi.com/products/$productId');
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (e) {
      throw Exception('Failed to load product details: $e');
    }
  }
}
