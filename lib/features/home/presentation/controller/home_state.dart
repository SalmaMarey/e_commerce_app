import 'package:e_commerce_app/core/models/product_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<String> categories;
  final List<Product> products;
  final String? selectedCategory;

  HomeLoaded(this.categories,
      {this.products = const [], this.selectedCategory});
}

class CategorySelected extends HomeState {
  final String selectedCategory;

  CategorySelected(this.selectedCategory);
}

class ProductsLoaded extends HomeState {
  final List<Product> products;

  ProductsLoaded(this.products);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
