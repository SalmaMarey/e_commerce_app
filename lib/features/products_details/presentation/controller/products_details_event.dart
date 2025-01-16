abstract class ProductDetailsEvent {}

class FetchProductDetailsEvent extends ProductDetailsEvent {
  final int productId;

  FetchProductDetailsEvent(this.productId);
}

class ToggleFavoriteEvent extends ProductDetailsEvent {}
