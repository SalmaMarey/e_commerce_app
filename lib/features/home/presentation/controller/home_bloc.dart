import 'package:e_commerce_app/features/home/domain/usecases/categories_usecase.dart';
import 'package:e_commerce_app/features/home/domain/usecases/get_product_by_category_use_case.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_event.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;

  HomeBloc(this.getCategoriesUseCase, this.getProductsByCategoryUseCase)
      : super(HomeInitial()) {
    on<FetchCategoriesEvent>(_onFetchCategories);
    on<FetchProductsByCategoryEvent>(_onFetchProductsByCategory);
  }

  void _onFetchCategories(
      FetchCategoriesEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final categories = await getCategoriesUseCase.call();
      emit(HomeLoaded(categories));

      if (categories.isNotEmpty) {
        add(FetchProductsByCategoryEvent(categories.first));
      }
    } catch (e) {
      emit(HomeError('Failed to fetch categories: $e'));
    }
  }

  void _onFetchProductsByCategory(
      FetchProductsByCategoryEvent event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(ProductsLoading(
          currentState.categories, currentState.selectedCategory));
      try {
        final products =
            await getProductsByCategoryUseCase.call(event.category);
        emit(HomeLoaded(
          currentState.categories,
          products: products,
          selectedCategory: event.category,
        ));
      } catch (e) {
        emit(HomeError('Failed to fetch products: $e'));
      }
    }
  }
}
