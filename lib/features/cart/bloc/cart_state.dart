import 'package:ecommerce_api/data/models/cart_item_model.dart';
import 'package:equatable/equatable.dart';

enum CartStatus {
  initial,
  loading,
  success,
  failure;

  static const CartStatus loaded = CartStatus.success;
}

extension CartStatusX on CartStatus {
  bool get isInitial => this == CartStatus.initial;
  bool get isLoading => this == CartStatus.loading;
  bool get isSuccess => this == CartStatus.success;
  bool get isFailure => this == CartStatus.failure;
}

class CartState extends Equatable {
  final CartStatus status;
  final List<CartItemModel> items;
  final String? lastActionMessage;

  const CartState({
    this.status = CartStatus.initial,
    this.items = const [],
    this.lastActionMessage,
  });

  bool get isInitial => status.isInitial;
  bool get isLoading => status.isLoading;
  bool get isSuccess => status.isSuccess;
  bool get isFailure => status.isFailure;

  int get totalItemCount =>
      items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get shippingFee =>
      subtotal == 0 || subtotal >= 50.0 ? 0.0 : 5.0;

  double get totalAmount => subtotal + shippingFee;

  bool containsProduct(int productId) =>
      items.any((item) => item.product.id == productId);

  int getProductQuantity(int productId) {
    final index = items.indexWhere((item) => item.product.id == productId);
    return index != -1 ? items[index].quantity : 0;
  }

  CartState copyWith({
    CartStatus? status,
    List<CartItemModel>? items,
    String? lastActionMessage,
  }) {
    return CartState(
      status: status ?? this.status,
      items: items ?? this.items,
      lastActionMessage: lastActionMessage,
    );
  }

  @override
  List<Object?> get props => [status, items, lastActionMessage];
}
