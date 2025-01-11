import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/features/products_details/domain/products_details_repo.dart';

class GetProductDetailsUseCase {
  final ProductDetailsRepository productDetailsRepository;

  GetProductDetailsUseCase(this.productDetailsRepository);

  Future<Product> call(int productId) async {
    return await productDetailsRepository.getProductDetails(productId);
  }
}
