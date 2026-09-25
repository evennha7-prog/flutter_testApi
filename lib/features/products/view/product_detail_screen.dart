import 'package:ecommerce_api/app/routes/app_routes.dart';
import 'package:ecommerce_api/core/widgets/cart_badge.dart';
import 'package:ecommerce_api/data/models/product_model.dart';
import 'package:ecommerce_api/features/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_api/features/products/widgets/product_bottom_bar.dart';
import 'package:ecommerce_api/features/products/widgets/product_description.dart';
import 'package:ecommerce_api/features/products/widgets/product_image_viewer.dart';
import 'package:ecommerce_api/features/products/widgets/product_info_header.dart';
import 'package:ecommerce_api/features/products/widgets/product_variant_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    super.key,
    this.product,
  });

  final ProductModel? product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 1;

  final List<Color> _colors = [
    Colors.black87,
    Colors.blueGrey,
    Colors.deepOrange.shade400,
    Colors.teal,
  ];

  final List<String> _sizes = ['S', 'M', 'L', 'XL'];

  @override
  Widget build(BuildContext context) {
    final product = widget.product ??
        ModalRoute.of(context)?.settings.arguments as ProductModel?;

    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Product Details')),
        body: const Center(child: Text('Product not found')),
      );
    }

    final isClothing = product.category.toLowerCase().contains('clothing');

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          product.category.toUpperCase(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              return CartIconButton(
                count: cartState.totalItemCount,
                onPressed: () => Navigator.pushNamed(context, Routes.cartScreen),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImageViewer(product: product),
                  ProductInfoHeader(
                    product: product,
                    quantity: _quantity,
                    onQuantityChanged: (value) =>
                        setState(() => _quantity = value),
                  ),
                  const SizedBox(height: 12),
                  if (isClothing) ...[
                    ProductVariantSelector(
                      colors: _colors,
                      sizes: _sizes,
                      selectedColorIndex: _selectedColorIndex,
                      selectedSizeIndex: _selectedSizeIndex,
                      onColorSelected: (index) =>
                          setState(() => _selectedColorIndex = index),
                      onSizeSelected: (index) =>
                          setState(() => _selectedSizeIndex = index),
                    ),
                    const SizedBox(height: 12),
                  ],
                  ProductDescription(description: product.description),
                ],
              ),
            ),
          ),
          ProductBottomBar(
            product: product,
            quantity: _quantity,
            isClothing: isClothing,
            selectedSize: isClothing ? _sizes[_selectedSizeIndex] : null,
          ),
        ],
      ),
    );
  }
}
