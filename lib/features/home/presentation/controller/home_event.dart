abstract class HomeEvent {}

class FetchCategoriesEvent extends HomeEvent {}

class SelectCategoryEvent extends HomeEvent {
  final String category;

  SelectCategoryEvent(this.category);
}

class FetchProductsByCategoryEvent extends HomeEvent {
  final String category;

  FetchProductsByCategoryEvent(this.category);
}
