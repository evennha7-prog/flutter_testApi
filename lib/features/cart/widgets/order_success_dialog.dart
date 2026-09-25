import 'package:ecommerce_api/core/constants/color_constants.dart';
import 'package:ecommerce_api/features/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_api/features/navigation/bloc/navbar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderSuccessDialog extends StatelessWidget {
  final double total;
  final int itemCount;
  final bool isStandalone;

  const OrderSuccessDialog({
    super.key,
    required this.total,
    required this.itemCount,
    this.isStandalone = false,
  });

  static Future<void> show(
    BuildContext context, {
    required double total,
    required int itemCount,
    bool isStandalone = false,
  }) {
    return showDialog(
      context: context,
      builder: (ctx) => OrderSuccessDialog(
        total: total,
        itemCount: itemCount,
        isStandalone: isStandalone,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              size: 60,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Order Placed!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Thank you for your order! Your purchase of $itemCount items for \$${total.toStringAsFixed(2)} was successful.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              context.read<CartBloc>().add(const ClearCartEvent());
              Navigator.pop(context);
              if (isStandalone) {
                Navigator.pop(context);
              } else {
                context.read<NavbarBloc>().add(const ChangeNavbarTabEvent(0));
              }
            },
            child: const Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }
}
