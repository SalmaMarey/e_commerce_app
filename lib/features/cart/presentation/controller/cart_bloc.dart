import 'package:e_commerce_app/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/get_cart_item_usecase.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:e_commerce_app/features/cart/domain/usecases/update_cart_item_quantity_usecase.dart';
import 'package:e_commerce_app/features/cart/presentation/controller/cart_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUseCase addToCartUseCase;
  final GetCartItemsUseCase getCartItemsUseCase;
  final UpdateCartItemQuantityUseCase updateCartItemQuantityUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final String userId;

  CartBloc({
    required this.addToCartUseCase,
    required this.getCartItemsUseCase,
    required this.updateCartItemQuantityUseCase,
    required this.removeFromCartUseCase,
    required this.userId,
  }) : super(CartInitial()) {
    on<AddToCartEvent>(_onAddToCartEvent);
    on<GetCartItemsEvent>(_onGetCartItemsEvent);
    on<UpdateCartItemQuantityEvent>(_onUpdateCartItemQuantityEvent);
    on<RemoveFromCartEvent>(_onRemoveFromCartEvent);
  }

  void _onAddToCartEvent(AddToCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final isAdded = await addToCartUseCase.execute(userId, event.cart);
    if (isAdded) {
      final cartItems = await getCartItemsUseCase.execute(userId);
      emit(CartLoaded(cartItems: cartItems));
    } else {
      emit(CartError(message: 'Product already in cart'));
    }
  }

  void _onGetCartItemsEvent(
      GetCartItemsEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cartItems = await getCartItemsUseCase.execute(userId);
      emit(CartLoaded(cartItems: cartItems));
    } catch (e) {
      emit(CartError(message: 'Failed to load cart items'));
    }
  }

  void _onUpdateCartItemQuantityEvent(
      UpdateCartItemQuantityEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await updateCartItemQuantityUseCase.execute(
          userId, event.cartItem, event.newQuantity);
      final cartItems = await getCartItemsUseCase.execute(userId);
      emit(CartLoaded(cartItems: cartItems));
    } catch (e) {
      emit(CartError(message: 'Failed to update quantity'));
    }
  }

  void _onRemoveFromCartEvent(
      RemoveFromCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await removeFromCartUseCase.execute(userId, event.cart);
      final cartItems = await getCartItemsUseCase.execute(userId);
      emit(CartLoaded(cartItems: cartItems));
    } catch (e) {
      emit(CartError(message: 'Failed to remove item from cart'));
    }
  }
}
