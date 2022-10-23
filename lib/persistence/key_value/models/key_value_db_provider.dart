import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/used_key_value_db_provider.dart';
import 'key_value_db.dart';

// Set the bool flag to true to show debug prints. Even if you forgot
// to set it to false, debug prints will not show in release builds.
// The handy part is that if it gets in the way in debugging, it is an easy
// toggle to turn it off here for just this feature. You can leave it true
// below to see this feature's logs in debug mode.
const bool _debug = !kReleaseMode && true;

/// Provides a [KeyValueDb] DB repository.
///
/// The value returned depends on the controller [usedKeyValueDbProvider].
final StateProvider<KeyValueDb> keyValueDbProvider =
    StateProvider<KeyValueDb>((StateProviderRef<KeyValueDb> ref) {
  ref.onDispose(
    () {
      if (_debug) debugPrint('keyValueDbProvider: onDispose called');
    },
  );
  return ref.watch(usedKeyValueDbProvider).get;
}, name: 'keyValueDbProvider');
