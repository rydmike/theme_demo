import 'key_value_repository.dart';
// ignore_for_file: comment_references

/// A repository that stores and retrieves key-value settings from memory only.
///
/// This class does not persist user settings, it only returns start default
/// values. The runtime in memory storage is handled by the key-value
/// controller.
///
/// To actually persist the settings locally, use the [ThemeServicePrefs]
/// implementation that uses the shared_preferences package to persists the
/// values, or the [ThemeServiceHive] that uses the hive package to accomplish
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
class KeyValueRepositoryMem implements KeyValueRepository {
  /// [KeyValueRepositoryMem] implementation needs no init, it is just a no op.
  @override
  Future<void> init() async {}

  /// [KeyValueRepositoryMem] implementation needs no dispose.
  @override
  Future<void> dispose() async {}

  /// Loads a setting from the data source, using a key to access it.
  /// Just returning default value for the in memory repository that does not
  /// persist values.
  @override
  Future<T> load<T>(String key, T defaultValue) async => defaultValue;

  /// Save a setting to the data source, using key, as key for the value.
  /// The in memory version does nothing, just a no op.
  @override
  Future<void> save<T>(String key, T value) async {}
}
