import 'package:ecommerce_api/core/constants/color_constants.dart';
import 'package:ecommerce_api/core/utils/app_text_style.dart';
import 'package:ecommerce_api/features/products/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categories',
              style: AppTextStyle.boldBlack(fontSize: 17),
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state.selectedCategory != 'All') {
                  return TextButton(
                    onPressed: () {
                      context
                          .read<ProductBloc>()
                          .add(const SelectCategoryEvent('All'));
                    },
                    child: const Text('Reset Filter'),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  final isSelected = state.selectedCategory.toLowerCase() ==
                      category.toLowerCase();
                  return ChoiceChip(
                    label: Text(
                      category[0].toUpperCase() + category.substring(1),
                    ),
                    selected: isSelected,
                    onSelected: (_) {
                      context
                          .read<ProductBloc>()
                          .add(SelectCategoryEvent(category));
                    },
                    selectedColor: AppColors.primaryColor,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 12,
                    ),
                    side: BorderSide(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.grey.shade300,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
