import 'package:ecommerce_api/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

enum SearchStatus { initial, loading, success, failure }

extension SearchStatusX on SearchStatus {
  bool get isInitial => this == SearchStatus.initial;
  bool get isLoading => this == SearchStatus.loading;
  bool get isSuccess => this == SearchStatus.success;
  bool get isFailure => this == SearchStatus.failure;
}

class SearchState extends Equatable {
  final SearchStatus status;
  final String searchQuery;
  final List<ProductModel> searchResults;
  final String? errorMessage;

  const SearchState({
    this.status = SearchStatus.initial,
    this.searchQuery = '',
    this.searchResults = const [],
    this.errorMessage,
  });

  bool get isInitial => status.isInitial;
  bool get isLoading => status.isLoading;
  bool get isSuccess => status.isSuccess;
  bool get isFailure => status.isFailure;

  SearchState copyWith({
    SearchStatus? status,
    String? searchQuery,
    List<ProductModel>? searchResults,
    String? errorMessage,
  }) {
    return SearchState(
      status: status ?? this.status,
      searchQuery: searchQuery ?? this.searchQuery,
      searchResults: searchResults ?? this.searchResults,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, searchQuery, searchResults, errorMessage];
}
