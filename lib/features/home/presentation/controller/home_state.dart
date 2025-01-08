abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<String> categories;

 HomeLoaded(this.categories);
}

class CategorySelected extends HomeState {
  final String selectedCategory;

  CategorySelected(this.selectedCategory);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}