import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Implementation of [BlocObserver] printing all state changes when not in
/// [kReleaseMode].
class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);

    if (!kReleaseMode) {
      log('$error', stackTrace: stackTrace);
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);

    if (!kReleaseMode) {
      debugPrint('$event event in $bloc');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    if (!kReleaseMode) {
      debugPrint('$transition transition in $bloc');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    if (!kReleaseMode) {
      debugPrint('$change');
    }
  }
}
