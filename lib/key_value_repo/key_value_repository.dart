/// Abstract interface for the [KeyValueRepository] used to read and save simple
/// key-value pairs.
abstract class KeyValueRepository {
  /// A [KeyValueRepository] implementation may override this method to perform
  /// needed initialization and setup work.
  Future<void> init();

  /// A [KeyValueRepository] implementation may override this method to perform
  /// needed cleanup on close/dispose.
  Future<void> dispose();

  /// Loads `value` from the [KeyValueRepository], stored with `key` string.
  ///
  /// If `key` does not exist in the repository, returns `defaultValue`.
  Future<T> load<T>(String key, T defaultValue);

  /// Save a value to the [KeyValueRepository] service, using `key` as its
  /// storage key.
  Future<void> save<T>(String key, T value);
}
