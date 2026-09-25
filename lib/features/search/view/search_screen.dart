import 'package:ecommerce_api/data/repositories/product_repository.dart';
import 'package:ecommerce_api/features/search/bloc/search_bloc.dart';
import 'package:ecommerce_api/features/search/widgets/search_bar_widget.dart';
import 'package:ecommerce_api/features/search/widgets/search_empty_view.dart';
import 'package:ecommerce_api/features/search/widgets/search_initial_view.dart';
import 'package:ecommerce_api/features/search/widgets/search_result_tile.dart';
import 'package:ecommerce_api/features/search/widgets/search_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        ProductRepository repo;
        try {
          repo = context.read<ProductRepository>();
        } catch (_) {
          repo = ProductRepository();
        }
        return SearchBloc(productRepository: repo);
      },
      child: const SearchView(),
    );
  }
}

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarWidget(
              controller: _searchController,
              onChanged: (query) {
                context.read<SearchBloc>().add(SearchQueryChangedEvent(query));
              },
              onClear: () {
                context.read<SearchBloc>().add(const ClearSearchEvent());
              },
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state.searchQuery.trim().isEmpty) {
                    return const SearchInitialView();
                  }

                  if (state.status == SearchStatus.loading) {
                    return const SearchShimmer();
                  }

                  if (state.status == SearchStatus.failure) {
                    return Center(
                      child: Text(
                        'Failed to load products',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    );
                  }

                  final results = state.searchResults;
                  if (results.isEmpty) {
                    return SearchEmptyView(query: state.searchQuery);
                  }

                  final displayProducts = results.take(4).toList();

                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: displayProducts.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, color: Colors.black12),
                    itemBuilder: (context, index) {
                      return SearchResultTile(
                        product: displayProducts[index],
                        query: state.searchQuery,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
