import 'package:ecommerce_api/features/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClearCartDialog extends StatelessWidget {
  const ClearCartDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => const ClearCartDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Clear Cart'),
      content: const Text(
        'Are you sure you want to remove all items from your cart?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            context.read<CartBloc>().add(const ClearCartEvent());
            Navigator.pop(context);
          },
          child: const Text(
            'Clear',
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
      ],
    );
  }
}
