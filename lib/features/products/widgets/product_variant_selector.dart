import 'package:ecommerce_api/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class ProductVariantSelector extends StatelessWidget {
  const ProductVariantSelector({
    super.key,
    required this.colors,
    required this.sizes,
    required this.selectedColorIndex,
    required this.selectedSizeIndex,
    required this.onColorSelected,
    required this.onSizeSelected,
  });

  final List<Color> colors;
  final List<String> sizes;
  final int selectedColorIndex;
  final int selectedSizeIndex;
  final ValueChanged<int> onColorSelected;
  final ValueChanged<int> onSizeSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Color',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(colors.length, (index) {
              final isSelected = selectedColorIndex == index;
              return GestureDetector(
                onTap: () => onColorSelected(index),
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: colors[index],
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 18),
          const Text(
            'Select Size',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(sizes.length, (index) {
              final isSelected = selectedSizeIndex == index;
              return GestureDetector(
                onTap: () => onSizeSelected(index),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryColor
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.grey.shade300,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    sizes[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
