import 'package:ecommerce_api/app/routes/app_routes.dart';
import 'package:ecommerce_api/app/routes/route_navigator.dart';
import 'package:ecommerce_api/core/theme/theme.dart';
import 'package:ecommerce_api/data/repositories/cart_repository.dart';
import 'package:ecommerce_api/data/repositories/product_repository.dart';
import 'package:ecommerce_api/features/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_api/features/products/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductRepository>(
          create: (_) => ProductRepository(),
        ),
        RepositoryProvider<CartRepository>(
          create: (_) => CartRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ProductBloc>(
            create: (context) => ProductBloc(
              productRepository: context.read<ProductRepository>(),
            )..add(const FetchProductsEvent()),
          ),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(
              cartRepository: context.read<CartRepository>(),
            )..add(const LoadCartEvent()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Khmer Retail Store',
          initialRoute: Routes.initial,
          routes: RouteNavigator.routes,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system,
        ),
      ),
    );
  }
}
