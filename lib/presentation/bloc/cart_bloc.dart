import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/cart_item_entity.dart';

abstract class CartEvent {}
class AddToCart extends CartEvent {
  final CartItemEntity item;
  AddToCart(this.item);
}
class RemoveFromCart extends CartEvent {
  final String productId;
  RemoveFromCart(this.productId);
}
class ClearCart extends CartEvent {}

abstract class CartState {}
class CartLoaded extends CartState {
  final List<CartItemEntity> items;
  CartLoaded(this.items);
}

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartItemEntity> _cart = [];

  CartBloc() : super(CartLoaded([])) {
    on<AddToCart>((event, emit) {
      final index = _cart.indexWhere((item) => item.product.id == event.item.product.id);
      if (index >= 0) {
        _cart[index] = CartItemEntity(
          product: _cart[index].product,
          quantity: _cart[index].quantity + event.item.quantity,
        );
      } else {
        _cart.add(event.item);
      }
      emit(CartLoaded(List.from(_cart)));
    });
    on<RemoveFromCart>((event, emit) {
      _cart.removeWhere((item) => item.product.id == event.productId);
      emit(CartLoaded(List.from(_cart)));
    });
    on<ClearCart>((event, emit) {
      _cart.clear();
      emit(CartLoaded(List.from(_cart)));
    });
  }
} 