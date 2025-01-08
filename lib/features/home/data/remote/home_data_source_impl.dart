import 'package:dio/dio.dart';
import 'package:e_commerce_app/features/home/data/remote/home_data_source.dart';

class HomeDataSourceImpl implements HomeDataSource {
  final Dio dio;
  HomeDataSourceImpl(this.dio);

  @override
  Future<List<String>> getCategories() async {
    try {
      final response =
          await dio.get('https://dummyjson.com/products/categories');
      if (response.statusCode == 200) {
        return List<String>.from(response.data);
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
}
