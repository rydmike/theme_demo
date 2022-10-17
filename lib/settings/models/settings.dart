import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../persistence/key_value/key_value_db.dart';

// TODO(rydmike): Clean up experimental code.

/// A persisted app settings class.
///
/// Settings can be of any value type that the used key-value DB implementation
/// supports.
class SettingsEntry<T> extends StateNotifier<T> {
  final Ref ref;
  final T defaultValue;
  final String key;

  SettingsEntry(
    this.ref, {
    required this.key,
    required this.defaultValue,
  }) : super(defaultValue) {
    // Get the key value DB
    final KeyValueDb db = ref.read(keyValueDbProvider);
    // Set cached value to value stored in key-valued DB, if
    // key does not exists, the db returns default value.
    // if (db.hasValue) {
    //   state = db.value!.get(key, defaultValue);
    // }
    state = db.get(key, defaultValue);
  }

  /// Update settings state value with a new value.
  ///
  /// Persist the value to key value db if it was different from
  /// previous value.
  Future<void> set(T newValue) async {
    if (state == newValue) return;
    final KeyValueDb db = ref.read(keyValueDbProvider);
    await db.put(key, newValue);
    // final AsyncValue<KeyValueDb> db = ref.read(keyValueDbFutureProvider);
    // if (db.hasValue) {
    //   state = newValue;
    //   await db.value!.put(key, newValue);
    // }
  }
}
