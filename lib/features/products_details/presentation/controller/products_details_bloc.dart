import 'package:e_commerce_app/features/products_details/domain/usecases/toggle_favorite_usecase.dart';
import 'package:e_commerce_app/features/products_details/domain/usecases/get_products_details_usecase.dart';
import 'package:e_commerce_app/features/products_details/domain/usecases/check_favorite_usecase.dart';
import 'package:e_commerce_app/features/products_details/presentation/controller/products_details_event.dart';
import 'package:e_commerce_app/features/products_details/presentation/controller/products_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  final CheckFavoriteUseCase checkFavoriteUseCase;

  ProductDetailsBloc({
    required this.getProductDetailsUseCase,
    required this.toggleFavoriteUseCase,
    required this.checkFavoriteUseCase,
  }) : super(ProductDetailsInitial()) {
    on<FetchProductDetailsEvent>(_onFetchProductDetails);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  void _onFetchProductDetails(
      FetchProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    emit(ProductDetailsLoading());
    try {
      final product = await getProductDetailsUseCase.call(event.productId);
      final isFavorited = checkFavoriteUseCase(product);
      emit(ProductDetailsLoaded(product, isFavorited));
    } catch (e) {
      emit(ProductDetailsError('Failed to fetch product details: $e'));
    }
  }

  void _onToggleFavorite(
      ToggleFavoriteEvent event, Emitter<ProductDetailsState> emit) async {
    final currentState = state;
    if (currentState is ProductDetailsLoaded) {
      await toggleFavoriteUseCase(currentState.product);
      final isFavorited = checkFavoriteUseCase(currentState.product);
      emit(ProductDetailsLoaded(currentState.product, isFavorited));
    }
  }
}
