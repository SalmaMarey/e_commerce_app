import '../../../../core/models/product_model.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsError extends ProductDetailsState {
  final String message;

  ProductDetailsError(this.message);
}

class ProductDetailsLoaded extends ProductDetailsState {
  final Product product;
  final bool isFavorited;

  ProductDetailsLoaded(this.product, this.isFavorited);
}
