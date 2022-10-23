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
    // Initialize the notifier's state value.
    init();
  }

  /// Init the settings entry from the used key-value DB implementation.
  ///
  /// Do use this init call when another key-value DB [KeyValueDb] has been
  /// switched to dynamically, in order update the [SettingsEntry] state to
  /// the value it has in the [KeyValueDb] swapped in. Using this init function
  /// ensures that a different value in the swapped in DB will also update all
  /// UI that uses this [SettingsEntry].
  ///
  /// Don't use this method to get the value of a [SettingsEntry] that is
  /// already initialized, use the current state value of the notifier for that.
  void init() {
    // Get the used-key value DB implementation.
    final KeyValueDb db = ref.read(keyValueDbProvider);
    // Read the value for the provided key from the used key-value DB.
    // The db value get returns the default value if key does not exist in it.
    final T newValue = db.get(key, defaultValue);
    // Only set state to db value, if it is different from current value.
    // StateNotifier does not emit a new state either if value is identical,
    // but we check too so we can exit earlier and to be very explicit about it.
    if (state != newValue) state = newValue;
  }

  /// Update the settings state with a new value.
  ///
  /// If the new value is different from current state value:
  /// - Assign new value to current state.
  /// - Persist the value to the used-key value DB implementation.
  void set(T newValue) {
    if (state == newValue) return;
    state = newValue;
    final KeyValueDb db = ref.read(keyValueDbProvider);
    unawaited(db.put(key, newValue));
  }

  /// Rest a settings entry state to its default value.
  ///
  /// If it already is at its default value, do no work, return.
  /// - Set state to default value.
  /// - Update the key-value DB value entry for this key, to its default value.
  void reset() {
    if (state == defaultValue) return;
    state = defaultValue;
    final KeyValueDb db = ref.read(keyValueDbProvider);
    unawaited(db.put(key, defaultValue));
  }
}
