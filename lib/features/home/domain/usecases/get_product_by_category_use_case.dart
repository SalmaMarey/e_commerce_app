import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/features/home/domain/home_repo.dart';

class GetProductsByCategoryUseCase {
  final HomeRepository homeRepository;

  GetProductsByCategoryUseCase(this.homeRepository);

  Future<List<Product>> call(String category) async {
    try {
      return await homeRepository.getProductsByCategory(category);
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
