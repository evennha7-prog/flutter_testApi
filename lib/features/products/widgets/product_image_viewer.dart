import 'package:ecommerce_api/core/widgets/app_network_image.dart';
import 'package:ecommerce_api/data/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductImageViewer extends StatelessWidget {
  const ProductImageViewer({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320,
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Hero(
          tag: 'product-image-${product.id}',
          child: AppNetworkImage(
            imageUrl: product.image,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
