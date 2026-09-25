import 'package:ecommerce_api/app/routes/app_routes.dart';
import 'package:ecommerce_api/core/constants/color_constants.dart';
import 'package:ecommerce_api/core/widgets/cart_badge.dart';
import 'package:ecommerce_api/features/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_api/features/navigation/bloc/navbar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      title: const Text(
        'Khmer Retail Store',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.15),
          ),
          child: IconButton(
            icon: const Icon(Icons.search_rounded, size: 22, color: Colors.white),
            onPressed: () {
              context.read<NavbarBloc>().add(const ChangeNavbarTabEvent(1));
            },
          ),
        ),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            return CartIconButton(
              count: cartState.totalItemCount,
              onPressed: () => Navigator.pushNamed(context, Routes.cartScreen),
            );
          },
        ),
      ],
    );
  }
}
