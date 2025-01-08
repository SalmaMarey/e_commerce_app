import 'package:e_commerce_app/features/home/presentation/controller/home_event.dart';
import 'package:e_commerce_app/features/home/presentation/controller/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchCategoriesEvent>(_onFetchCategories);
    on<SelectCategoryEvent>(_onSelectCategory);
  }

  void _onFetchCategories(
      FetchCategoriesEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final List<String> categories = await _fetchCategories();
      emit(HomeLoaded(categories));
    } catch (e) {
      emit(HomeError('Failed to fetch categories: $e'));
    }
  }

  void _onSelectCategory(SelectCategoryEvent event, Emitter<HomeState> emit) {
    emit(CategorySelected(event.category));
  }

  Future<List<String>> _fetchCategories() async {
    await Future.delayed(const Duration(seconds: 1));
    return ['Electronics', 'Clothing', 'Home', 'Books'];
  }
}
