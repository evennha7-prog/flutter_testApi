import 'package:ecommerce_api/core/errors/app_exceptions.dart';
import 'package:ecommerce_api/data/models/product_model.dart';
import 'package:ecommerce_api/data/repositories/product_repository.dart';
import 'package:ecommerce_api/features/products/bloc/product_event.dart';
import 'package:ecommerce_api/features/products/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'product_event.dart';
export 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc({ProductRepository? productRepository})
      : _productRepository = productRepository ?? ProductRepository(),
        super(const ProductState()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<SelectCategoryEvent>(_onSelectCategory);
    on<SearchProductsEvent>(_onSearchProducts);
  }

  Future<void> _onFetchProducts(
    FetchProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    if (state.products.isEmpty || event.refresh) {
      emit(state.copyWith(status: ProductStatus.loading));
    }

    try {
      final productsFuture = _productRepository.getProducts();
      final categoriesFuture = _productRepository.getCategories();

      final results = await Future.wait([productsFuture, categoriesFuture]);
      final products = results[0] as List<ProductModel>;
      final rawCategories = results[1] as List<String>;
      final categories = ['All', ...rawCategories];

      emit(state.copyWith(
        status: ProductStatus.success,
        products: products,
        categories: categories,
      ));
    } on NetworkException catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: e.message,
      ));
    } on ServerException catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onSelectCategory(
    SelectCategoryEvent event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(selectedCategory: event.category));
  }

  void _onSearchProducts(
    SearchProductsEvent event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
  }
}
