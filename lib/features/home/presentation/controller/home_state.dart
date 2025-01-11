import 'package:e_commerce_app/core/models/product_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<String> categories;
  final List<Product> products;
  final List<Product> originalProducts;
  final String? selectedCategory;

  HomeLoaded(
    this.categories, {
    this.products = const [],
    this.selectedCategory,
    required this.originalProducts,
  });
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

class ProductsLoading extends HomeState {
  final List<String> categories;
  final String? selectedCategory;

  ProductsLoading(this.categories, this.selectedCategory);
}
