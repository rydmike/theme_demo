import 'key_value_db.dart';
// ignore_for_file: comment_references

/// A DB repository that stores and retrieves key-value settings from voltile
/// memory only.
///
/// This class does not persist user settings, it only returns start default
/// values. The runtime in memory storage is handled by the key-value
/// controller.
///
/// To actually persist the settings locally, use the [KeyValueDbMemPrefs]
/// implementation that uses the shared_preferences package to persists the
/// values, or the [KeyValueDbMemHive] that uses the Hive package to accomplish
/// the same thing. You could also make an implementation that stores settings
/// on a web server, e.g. with the http package.
///
/// A controller that this is data source is used with, should keep all latest
/// setting values in memory itself, so this memory implementation
/// does not really do anything when calling save for each property,
/// they are all just no-op.
///
/// Loading values from it just returns the default value for each settings
/// property.
class KeyValueDbMem implements KeyValueDb {
  /// [KeyValueDbMem] implementation needs no init, it is just a no op.
  @override
  Future<void> init() async {}

  /// [KeyValueDbMem] implementation needs no dispose.
  @override
  Future<void> dispose() async {}

  /// Get a setting from the data source, using a key to access it.
  ///
  /// Return default value for the in memory repository that does not
  /// persist values.
  @override
  T get<T>(String key, T defaultValue) => defaultValue;

  /// Put a setting to the data source, using key, as key for the value.
  ///
  /// The in memory version does nothing, just a no op.
  @override
  Future<void> put<T>(String key, T value) async {}
}
