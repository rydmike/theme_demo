import 'package:flutter/foundation.dart';

import 'key_value_db.dart';
// ignore_for_file: comment_references

// Set the bool flag to true to show debug prints. Even if you forgot
// to set it to false, debug prints will not show in release builds.
// The handy part is that if it gets in the way in debugging, it is an easy
// toggle to turn it off here too for just this feature. You can leave it true
// below to see this features logs in debug mode.
const bool _debug = !kReleaseMode && true;

/// A repository that stores and retrieves key-value settings pairs from
/// volatile ram memory.
///
/// This class keeps the key-value pairs in a private static final Map during
/// app execution, so we can get the same Map data also when we get a
/// new instance of the mem key-value db, this happens when we dynamically in
/// the app switch to another implementation and back to mem again.
///
/// To actually persist the settings locally, use the [KeyValueDbMemPrefs]
/// implementation that uses the shared_preferences package to persists the
/// values, or the [KeyValueDbMemHive] that uses the Hive package to accomplish
/// the same thing. You could also make an implementation that stores settings
/// on a web server, e.g. with the http package.
class KeyValueDbMem implements KeyValueDb {
  // A private static Map that stores the key-value pairs.
  // This is kept in ram memory as long as app runs.
  static final Map<String, dynamic> _memKeyValueDb = <String, dynamic>{};

  /// [KeyValueDbMem] implementation needs no init functionality.
  @override
  Future<void> init() async {
    if (_debug) debugPrint('KeyValueDbMem: init called');
  }

  /// [KeyValueDbMem] implementation needs no dispose functionality.
  @override
  Future<void> dispose() async {
    if (_debug) debugPrint('KeyValueDbMem: dispose called');
  }

  /// Get a settings value from the mem db, using [key] to access it.
  ///
  /// If key does not exist, return the [defaultValue].
  /// persist values.
  @override
  T get<T>(String key, T defaultValue) {
    try {
      if (_memKeyValueDb.containsKey(key)) {
        final T value = _memKeyValueDb[key] as T;
        if (_debug) {
          debugPrint('MemDB get   : ["$key"] = $value (${value.runtimeType})');
        }
        if (value == null) {
          return null as T;
        } else {
          return value;
        }
      } else {
        return defaultValue;
      }
    } catch (e) {
      debugPrint('MemDB get (load) ERROR');
      debugPrint(' Error message ...... : $e');
      debugPrint(' Store key .......... : $key');
      debugPrint(' defaultValue ....... : $defaultValue');
    }
    // If something went wrong we return the default value.
    return defaultValue;
  }

  /// Put a settings [value] to the mem db, using [key], as key for the value.
  @override
  Future<void> put<T>(String key, T value) async {
    if (_debug) {
      debugPrint('MemDB put   : ["$key"] = $value (${value.runtimeType})');
    }
    _memKeyValueDb[key] = value;
  }
}
