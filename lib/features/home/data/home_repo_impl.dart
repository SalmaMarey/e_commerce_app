import 'package:e_commerce_app/features/home/data/remote/home_data_source.dart';
import 'package:e_commerce_app/features/home/domain/home_repo.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource homedataSource;

  HomeRepositoryImpl(this.homedataSource);

  @override
  Future<List<String>> getCategories() {
    return homedataSource.getCategories();
  }
}
