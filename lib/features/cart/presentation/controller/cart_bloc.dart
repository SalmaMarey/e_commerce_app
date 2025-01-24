import 'package:e_commerce_app/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/get_cart_item_usecase.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:e_commerce_app/features/cart/presentation/controller/cart_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';
class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUseCase addToCartUseCase;
  final GetCartItemsUseCase getCartItemsUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase; 
  final String userId;

  CartBloc({
    required this.addToCartUseCase,
    required this.getCartItemsUseCase, 
    required this.removeFromCartUseCase,
    required this.userId,
  }) : super(CartInitial()) {
    on<AddToCartEvent>(_onAddToCartEvent);
    on<GetCartItemsEvent>(_onGetCartItemsEvent);
    on<RemoveFromCartEvent>(_onRemoveFromCartEvent); 
  }

  void _onAddToCartEvent(AddToCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    await addToCartUseCase.execute(userId, event.cart);
    final cartItems = await getCartItemsUseCase.execute(userId);
    emit(CartLoaded(cartItems: cartItems));
  }

  void _onGetCartItemsEvent(GetCartItemsEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final cartItems = await getCartItemsUseCase.execute(userId);
    emit(CartLoaded(cartItems: cartItems));
  }

  void _onRemoveFromCartEvent(RemoveFromCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    await removeFromCartUseCase.execute(userId, event.cart);
    final cartItems = await getCartItemsUseCase.execute(userId);
    emit(CartLoaded(cartItems: cartItems));
  }
}