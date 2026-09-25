import 'package:ecommerce_api/app/routes/app_routes.dart';
import 'package:ecommerce_api/features/cart/view/cart_screen.dart';
import 'package:ecommerce_api/features/home/view/home_screen.dart';
import 'package:ecommerce_api/features/navigation/bloc/navbar_bloc.dart';
import 'package:ecommerce_api/features/navigation/view/navbar_screen.dart';
import 'package:ecommerce_api/features/products/view/product_detail_screen.dart';
import 'package:ecommerce_api/features/profile/view/profile_screen.dart';
import 'package:ecommerce_api/features/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class RouteNavigator {
  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.splash: (BuildContext context) => const SplashScreen(),
    Routes.homeScreen: (BuildContext context) => const HomeScreen(),
    Routes.productDetail: (BuildContext context) => const ProductDetailScreen(),
    Routes.cartScreen: (BuildContext context) =>
        const ShoppingCart(isStandalone: true),
    Routes.navbar: (BuildContext context) => BlocProvider(
          create: (context) => NavbarBloc(),
          child: const Navbar(),
        ),
    Routes.profile: (BuildContext context) => const Profile(),
    Routes.shoppingCart: (BuildContext context) => const ShoppingCart(),
  };
}
