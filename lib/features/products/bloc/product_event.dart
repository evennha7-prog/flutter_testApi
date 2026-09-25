import 'package:equatable/equatable.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

final class FetchProductsEvent extends ProductEvent {
  final bool refresh;

  const FetchProductsEvent({this.refresh = false});

  @override
  List<Object?> get props => [refresh];
}

final class SelectCategoryEvent extends ProductEvent {
  final String category;

  const SelectCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}

final class SearchProductsEvent extends ProductEvent {
  final String query;

  const SearchProductsEvent(this.query);

  @override
  List<Object?> get props => [query];
}
