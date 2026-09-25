import 'package:ecommerce_api/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

enum ProductStatus { initial, loading, success, failure }

extension ProductStatusX on ProductStatus {
  bool get isInitial => this == ProductStatus.initial;
  bool get isLoading => this == ProductStatus.loading;
  bool get isSuccess => this == ProductStatus.success;
  bool get isFailure => this == ProductStatus.failure;
}

class ProductState extends Equatable {
  final ProductStatus status;
  final List<ProductModel> products;
  final List<String> categories;
  final String selectedCategory;
  final String searchQuery;
  final String? errorMessage;

  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const [],
    this.categories = const ['All'],
    this.selectedCategory = 'All',
    this.searchQuery = '',
    this.errorMessage,
  });

  bool get isInitial => status.isInitial;
  bool get isLoading => status.isLoading;
  bool get isSuccess => status.isSuccess;
  bool get isFailure => status.isFailure;

  List<ProductModel> get filteredProducts {
    return products.where((product) {
      final matchesCategory = selectedCategory == 'All' ||
          product.category.toLowerCase() == selectedCategory.toLowerCase();
      final matchesSearch = searchQuery.trim().isEmpty ||
          product.title
              .toLowerCase()
              .contains(searchQuery.toLowerCase().trim()) ||
          product.description
              .toLowerCase()
              .contains(searchQuery.toLowerCase().trim());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  ProductState copyWith({
    ProductStatus? status,
    List<ProductModel>? products,
    List<String>? categories,
    String? selectedCategory,
    String? searchQuery,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        categories,
        selectedCategory,
        searchQuery,
        errorMessage,
      ];
}
