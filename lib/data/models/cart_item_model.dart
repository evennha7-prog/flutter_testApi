import 'package:equatable/equatable.dart';
import 'package:ecommerce_api/data/models/product_model.dart';

class CartItemModel extends Equatable {
  final ProductModel product;
  final int quantity;
  final String? selectedColor;
  final String? selectedSize;

  const CartItemModel({
    required this.product,
    this.quantity = 1,
    this.selectedColor,
    this.selectedSize,
  });

  double get totalPrice => product.price * quantity;

  CartItemModel copyWith({
    ProductModel? product,
    int? quantity,
    String? selectedColor,
    String? selectedSize,
  }) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
    );
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      selectedColor: json['selectedColor'] as String?,
      selectedSize: json['selectedSize'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
        'quantity': quantity,
        if (selectedColor != null) 'selectedColor': selectedColor,
        if (selectedSize != null) 'selectedSize': selectedSize,
      };

  @override
  List<Object?> get props => [product, quantity, selectedColor, selectedSize];
}
