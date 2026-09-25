import 'package:ecommerce_api/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

final class LoadCartEvent extends CartEvent {
  const LoadCartEvent();
}

final class AddToCartEvent extends CartEvent {
  final ProductModel product;
  final int quantity;
  final String? color;
  final String? size;

  const AddToCartEvent({
    required this.product,
    this.quantity = 1,
    this.color,
    this.size,
  });

  @override
  List<Object?> get props => [product, quantity, color, size];
}

final class RemoveFromCartEvent extends CartEvent {
  final int productId;

  const RemoveFromCartEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

final class IncrementCartQuantityEvent extends CartEvent {
  final int productId;

  const IncrementCartQuantityEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

final class DecrementCartQuantityEvent extends CartEvent {
  final int productId;

  const DecrementCartQuantityEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

final class ClearCartEvent extends CartEvent {
  const ClearCartEvent();
}
