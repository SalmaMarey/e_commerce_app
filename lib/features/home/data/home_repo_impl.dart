import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/features/home/data/remote/home_data_source.dart';
import 'package:e_commerce_app/features/home/domain/home_repo.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource homeDataSource;

  HomeRepositoryImpl(this.homeDataSource);

  @override
  Future<List<String>> getCategories() {
    return homeDataSource.getCategories();
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) {
    return homeDataSource.getProductsByCategory(category);
  }
}
