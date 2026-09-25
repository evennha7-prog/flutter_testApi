import 'package:ecommerce_api/core/widgets/base_screen.dart';
import 'package:ecommerce_api/core/widgets/custom_bottom_nav_bar.dart';
import 'package:ecommerce_api/features/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_api/features/cart/view/cart_screen.dart';
import 'package:ecommerce_api/features/home/view/home_screen.dart';
import 'package:ecommerce_api/features/navigation/bloc/navbar_bloc.dart';
import 'package:ecommerce_api/features/profile/view/profile_screen.dart';
import 'package:ecommerce_api/features/search/view/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  static const List<Widget> _tabs = [
    HomeScreen(),
    SearchScreen(),
    ShoppingCart(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarBloc, NavbarState>(
      buildWhen: (previous, current) =>
          previous.currentIndex != current.currentIndex,
      builder: (context, state) {
        return BaseScreen(
          padding: EdgeInsets.zero,
          body: IndexedStack(
            index: state.currentIndex,
            children: _tabs,
          ),
          bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              return CustomBottomNavBar(
                currentIndex: state.currentIndex,
                cartBadgeCount: cartState.totalItemCount,
                onTap: (index) {
                  context.read<NavbarBloc>().add(ChangeNavbarTabEvent(index));
                },
              );
            },
          ),
        );
      },
    );
  }
}
