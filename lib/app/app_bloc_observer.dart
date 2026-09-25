import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [AppBlocObserver] monitors all Bloc events, transitions, changes, and errors across the application.
/// Logging is only active in debug mode to prevent sensitive data leaks in production builds.
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      developer.log('onEvent: ${bloc.runtimeType} -> $event', name: 'AppBlocObserver');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      developer.log('onChange: ${bloc.runtimeType} -> $change', name: 'AppBlocObserver');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      developer.log('onTransition: ${bloc.runtimeType} -> $transition', name: 'AppBlocObserver');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      developer.log(
        'onError: ${bloc.runtimeType} -> $error',
        name: 'AppBlocObserver',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
