import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Set the bool flag to true to show debug prints. Even if it is forgotten
// to set it to false, debug prints will not show in release builds.
// The handy part is that if it gets in the way in debugging, it is an easy
// toggle to turn it off there too. Often I just leave them true if it is one
// I want to see in dev mode, unless it is too chatty
const bool _debug = !kReleaseMode && true;

/// AppProviderObserver represents a provider observer for changes in any
/// providers. If not in release mode, it debugPrints the changes.
class AppProviderObserver extends ProviderObserver {
  AppProviderObserver();

  @override
  Future<void> didUpdateProvider(
      ProviderBase<dynamic> provider,
      Object? previousValue,
      Object? newValue,
      ProviderContainer container) async {
    if (_debug) {
      debugPrint('PROVIDER    : ${provider.name ?? '<NO NAME>'}\n'
          '  Type      : ${provider.runtimeType}\n'
          '  Old value : $previousValue\n'
          '  New value : $newValue');
    }
  }
}
