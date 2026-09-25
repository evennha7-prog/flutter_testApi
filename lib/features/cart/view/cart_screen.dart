import 'package:ecommerce_api/features/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_api/features/cart/widgets/cart_empty_view.dart';
import 'package:ecommerce_api/features/cart/widgets/cart_item_tile.dart';
import 'package:ecommerce_api/features/cart/widgets/cart_summary.dart';
import 'package:ecommerce_api/features/cart/widgets/clear_cart_dialog.dart';
import 'package:ecommerce_api/features/cart/widgets/order_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key, this.isStandalone = false});

  final bool isStandalone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        automaticallyImplyLeading: isStandalone,
        leading: isStandalone
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.white),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: const Text('My Cart'),
        centerTitle: true,
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state.items.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.delete_sweep_outlined,
                      color: Colors.white),
                  onPressed: () => ClearCartDialog.show(context),
                  tooltip: 'Clear Cart',
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listenWhen: (previous, current) =>
            current.lastActionMessage != null &&
            current.lastActionMessage != previous.lastActionMessage,
        listener: (context, state) {
          if (state.lastActionMessage != null) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.lastActionMessage!),
                duration: const Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == CartStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.items.isEmpty) {
            return CartEmptyView(isStandalone: isStandalone);
          }

          final double subtotal = state.subtotal;
          final double total = subtotal;

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return CartItemTile(item: state.items[index]);
                  },
                ),
              ),
              CartSummary(
                subtotal: subtotal,
                total: total,
                onCheckout: () {
                  OrderSuccessDialog.show(
                    context,
                    total: total,
                    itemCount: state.totalItemCount,
                    isStandalone: isStandalone,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
