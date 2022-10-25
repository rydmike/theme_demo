import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../settings/controllers/settings.dart';
import 'key_value_db.dart';
import 'key_value_db_provider.dart';

// Set the bool flag to true to show debug prints. Even if you forgot
// to set it to false, debug prints will not show in release builds.
// The handy part is that if it gets in the way in debugging, it is an easy
// toggle to turn it off here for just this feature. You can leave it true
// below to see this feature's logs in debug mode.
const bool _debug = !kReleaseMode && true;

/// A listener that listens to changes in the [keyValueDbProvider].
///
/// When the [keyValueDbProvider] state changes, we initialize the
/// new provided DB and read all its DB values and updates UI settings
/// controls to the values from the new [KeyValueDb] implementation.
class KeyValueDbListener {
  // Pass a Ref argument to the constructor
  KeyValueDbListener(this.ref) {
    if (_debug) debugPrint('KeyValueDbListener: new instance');
    // Call _init as soon as the object is created
    _init();
  }
  final Ref ref;

  void _init() {
    if (_debug) debugPrint('KeyValueDbListener: _init() setup listen');
    // Listen to state changes in keyValueDbProvider.state.
    ref.listen<StateController<KeyValueDb>>(keyValueDbProvider.state,
        (StateController<KeyValueDb>? previous,
            StateController<KeyValueDb> current) async {
      // This callback executes when the keyValueDbProvider value changes.
      if (_debug) {
        debugPrint('KeyValueDbListener: listen called - - - - -');
        debugPrint('  DB switch : ${current.state}');
      }
      // Get the new un-initialized keyValueDb and initialize it.
      final KeyValueDb keyValueDb = current.state;
      await keyValueDb.init();
      // We changed key valued DB, we must update all settings controls.
      Settings.init(ref);
    });
  }
}

/// A provider used to read and activate a [KeyValueDbListener].
final Provider<KeyValueDbListener> keyValueDbListenerProvider =
    Provider<KeyValueDbListener>((ProviderRef<KeyValueDbListener> ref) {
  if (_debug) debugPrint('keyValueDbListenerProvider called');
  return KeyValueDbListener(ref);
});
