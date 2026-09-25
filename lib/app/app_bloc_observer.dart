import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';

/// [AppBlocObserver] monitors all Bloc events, transitions, changes, and errors across the application.
/// Following the official Bloc best practices standard.
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    developer.log('onEvent: ${bloc.runtimeType} -> $event', name: 'AppBlocObserver');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    developer.log('onChange: ${bloc.runtimeType} -> $change', name: 'AppBlocObserver');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    developer.log('onTransition: ${bloc.runtimeType} -> $transition', name: 'AppBlocObserver');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    developer.log(
      'onError: ${bloc.runtimeType} -> $error',
      name: 'AppBlocObserver',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
