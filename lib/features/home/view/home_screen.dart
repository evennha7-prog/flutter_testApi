import 'package:ecommerce_api/core/constants/color_constants.dart';
import 'package:ecommerce_api/features/home/widgets/home_categories.dart';
import 'package:ecommerce_api/features/home/widgets/home_header.dart';
import 'package:ecommerce_api/features/home/widgets/home_product_grid.dart';
import 'package:ecommerce_api/features/products/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: const HomeHeader(),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            context
                .read<ProductBloc>()
                .add(const FetchProductsEvent(refresh: true));
          },
          child: const SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(18, 16, 18, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeCategories(),
                  SizedBox(height: 18),
                  HomeProductGrid(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
