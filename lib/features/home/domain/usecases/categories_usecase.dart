import 'package:e_commerce_app/features/home/domain/home_repo.dart';

class GetCategoriesUseCase {
  final HomeRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<String>> call() {
    return repository.getCategories();
  }
}
