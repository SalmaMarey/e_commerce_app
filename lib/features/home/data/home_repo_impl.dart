import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/features/home/data/remote/home_data_source.dart';
import 'package:e_commerce_app/features/home/domain/home_repo.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource homeDataSource;

  HomeRepositoryImpl(this.homeDataSource);

  @override
  Future<List<String>> getCategories() async {
    try {
      return await homeDataSource.getCategories();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      return await homeDataSource.getProductsByCategory(category);
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
