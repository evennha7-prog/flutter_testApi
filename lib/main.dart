import 'package:ecommerce_api/app/app.dart';
import 'package:ecommerce_api/app/app_bloc_observer.dart';
import 'package:ecommerce_api/data/datasources/preference_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  await PreferenceProvider.instance.init();
  runApp(const MyApp());
}