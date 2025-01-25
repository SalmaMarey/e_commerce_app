import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/network/internet_checker.dart';
import 'package:e_commerce_app/features/home/data/remote/home_data_source.dart';

class HomeDataSourceImpl implements HomeDataSource {
  final Dio dio;

  HomeDataSourceImpl(this.dio);

  @override
  Future<List<String>> getCategories() async {
    try {
      final response =
          await dio.get('https://fakestoreapi.com/products/categories');
      if (response.statusCode == 200) {
        return List<String>.from(response.data);
      } else {
        throw NetworkException(
            'Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final response =
          await dio.get('https://fakestoreapi.com/products/category/$category');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => Product.fromJson(json))
            .toList();
      } else {
        throw NetworkException(
            'Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
