import 'package:e_commerce_app/features/products_details/domain/usecases/get_products_details_usecase.dart';
import 'package:e_commerce_app/features/products_details/presentation/controller/products_details_event.dart';
import 'package:e_commerce_app/features/products_details/presentation/controller/products_details_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;

  ProductDetailsBloc(this.getProductDetailsUseCase) : super(ProductDetailsInitial()) {
    on<FetchProductDetailsEvent>(_onFetchProductDetails);
  }

  void _onFetchProductDetails(FetchProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    emit(ProductDetailsLoading());
    try {
      final product = await getProductDetailsUseCase.call(event.productId);
      emit(ProductDetailsLoaded(product));
    } catch (e) {
      emit(ProductDetailsError('Failed to fetch product details: $e'));
    }
  }
}