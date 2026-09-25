import 'package:ecommerce_api/data/models/cart_item_model.dart';
import 'package:ecommerce_api/data/repositories/cart_repository.dart';
import 'package:ecommerce_api/features/cart/bloc/cart_event.dart';
import 'package:ecommerce_api/features/cart/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'cart_event.dart';
export 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;

  CartBloc({CartRepository? cartRepository})
      : _cartRepository = cartRepository ?? CartRepository(),
        super(const CartState()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<IncrementCartQuantityEvent>(_onIncrementQuantity);
    on<DecrementCartQuantityEvent>(_onDecrementQuantity);
    on<ClearCartEvent>(_onClearCart);
  }

  Future<void> _onLoadCart(
    LoadCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(status: CartStatus.loading));
    final items = await _cartRepository.loadCart();
    emit(state.copyWith(
      status: CartStatus.loaded,
      items: items,
    ));
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final existingIndex = state.items.indexWhere(
      (item) => item.product.id == event.product.id,
    );

    List<CartItemModel> updatedItems;
    if (existingIndex >= 0) {
      updatedItems = List.from(state.items);
      final currentItem = updatedItems[existingIndex];
      updatedItems[existingIndex] = currentItem.copyWith(
        quantity: currentItem.quantity + event.quantity,
        selectedColor: event.color ?? currentItem.selectedColor,
        selectedSize: event.size ?? currentItem.selectedSize,
      );
    } else {
      updatedItems = [
        ...state.items,
        CartItemModel(
          product: event.product,
          quantity: event.quantity,
          selectedColor: event.color,
          selectedSize: event.size,
        ),
      ];
    }

    emit(state.copyWith(
      items: updatedItems,
      lastActionMessage: 'Added to cart',
    ));
    await _cartRepository.saveCart(updatedItems);
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final updatedItems = state.items
        .where((item) => item.product.id != event.productId)
        .toList();
    emit(state.copyWith(
      items: updatedItems,
      lastActionMessage: 'Item removed from cart',
    ));
    await _cartRepository.saveCart(updatedItems);
  }

  Future<void> _onIncrementQuantity(
    IncrementCartQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    final updatedItems = state.items.map((item) {
      if (item.product.id == event.productId) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();

    emit(state.copyWith(items: updatedItems));
    await _cartRepository.saveCart(updatedItems);
  }

  Future<void> _onDecrementQuantity(
    DecrementCartQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    final existingIndex = state.items.indexWhere(
      (item) => item.product.id == event.productId,
    );

    if (existingIndex < 0) return;

    final currentItem = state.items[existingIndex];
    if (currentItem.quantity > 1) {
      final updatedItems = List<CartItemModel>.from(state.items);
      updatedItems[existingIndex] = currentItem.copyWith(
        quantity: currentItem.quantity - 1,
      );
      emit(state.copyWith(items: updatedItems));
      await _cartRepository.saveCart(updatedItems);
    } else {
      add(RemoveFromCartEvent(event.productId));
    }
  }

  Future<void> _onClearCart(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(items: []));
    await _cartRepository.saveCart([]);
  }
}
