import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../persistence/key_value/models/key_value_db.dart';
import '../../persistence/key_value/models/key_value_db_provider.dart';

/// A persisted app settings entry class.
///
/// Can be of any value type that the used key-value DB implementation supports.
class SettingsEntry<T> extends StateNotifier<T> {
  final Ref ref;
  final T defaultValue;
  final String key;

  SettingsEntry(
    this.ref, {
    required this.key,
    required this.defaultValue,
  }) : super(defaultValue) {
    // Initialize the state value of the notifier.
    get();
  }

  /// Get the settings entry from the key value Db.
  void get() {
    final KeyValueDb db = ref.read(keyValueDbProvider);
    // The db getter returns the default value if key does not exist.
    final T newValue = db.get(key, defaultValue);
    // don't set db value to state, if it is same as before.
    if (state != newValue) state = newValue;
  }

  /// Update settings state value with a new value.
  ///
  /// Persist the value to key value db if it was different from previous value.
  void set(T newValue) {
    if (state == newValue) return;
    final KeyValueDb db = ref.read(keyValueDbProvider);
    state = newValue;
    unawaited(db.put(key, newValue));
  }

  /// Rest a setting to its default value
  void reset() {
    if (state == defaultValue) return;
    final KeyValueDb db = ref.read(keyValueDbProvider);
    state = defaultValue;
    unawaited(db.put(key, defaultValue));
  }
}
