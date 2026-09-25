import 'package:ecommerce_api/app/routes/app_routes.dart';
import 'package:ecommerce_api/data/models/product_model.dart';
import 'package:flutter/material.dart';

class SearchResultTile extends StatelessWidget {
  final ProductModel product;
  final String query;

  const SearchResultTile({
    super.key,
    required this.product,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    final String title = product.title;
    final String trimmedQuery = query.trim().toLowerCase();
    final int matchIndex = title.toLowerCase().indexOf(trimmedQuery);

    final List<TextSpan> textSpans = [];

    if (matchIndex != -1) {
      if (matchIndex > 0) {
        textSpans.add(TextSpan(
          text: title.substring(0, matchIndex),
          style: TextStyle(color: Colors.grey.shade500),
        ));
      }
      textSpans.add(TextSpan(
        text: title.substring(matchIndex, matchIndex + trimmedQuery.length),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ));
      if (matchIndex + trimmedQuery.length < title.length) {
        textSpans.add(TextSpan(
          text: title.substring(matchIndex + trimmedQuery.length),
          style: TextStyle(color: Colors.grey.shade500),
        ));
      }
    } else {
      textSpans.add(TextSpan(
        text: title,
        style: TextStyle(color: Colors.grey.shade500),
      ));
    }

    return ListTile(
      leading: Icon(Icons.search, color: Colors.grey.shade600, size: 20),
      title: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16),
          children: textSpans,
        ),
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.productDetail,
          arguments: product,
        );
      },
    );
  }
}
