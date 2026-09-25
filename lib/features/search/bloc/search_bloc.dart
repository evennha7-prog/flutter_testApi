import 'package:ecommerce_api/core/errors/app_exceptions.dart';
import 'package:ecommerce_api/data/models/product_model.dart';
import 'package:ecommerce_api/data/repositories/product_repository.dart';
import 'package:ecommerce_api/features/search/bloc/search_event.dart';
import 'package:ecommerce_api/features/search/bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'search_event.dart';
export 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductRepository _productRepository;
  List<ProductModel> _allProducts = [];

  SearchBloc({ProductRepository? productRepository})
      : _productRepository = productRepository ?? ProductRepository(),
        super(const SearchState()) {
    on<SearchQueryChangedEvent>(_onSearchQueryChanged);
    on<ClearSearchEvent>(_onClearSearch);
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChangedEvent event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) {
      emit(const SearchState());
      return;
    }

    emit(state.copyWith(
      status: SearchStatus.loading,
      searchQuery: event.query,
    ));

    try {
      if (_allProducts.isEmpty) {
        _allProducts = await _productRepository.getProducts();
      }

      final filtered = _allProducts.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase());
      }).toList();

      emit(state.copyWith(
        status: SearchStatus.success,
        searchResults: filtered,
        searchQuery: event.query,
      ));
    } on NetworkException catch (e) {
      emit(state.copyWith(
        status: SearchStatus.failure,
        errorMessage: e.message,
      ));
    } on ServerException catch (e) {
      emit(state.copyWith(
        status: SearchStatus.failure,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SearchStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onClearSearch(
    ClearSearchEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(const SearchState());
  }
}
