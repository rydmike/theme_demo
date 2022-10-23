/// Abstract interface for the [KeyValueDb] used to get and put (save) simple
/// key-value pairs.
abstract class KeyValueDb {
  /// A [KeyValueDb] implementation may override this method to perform
  /// all its needed initialization and setup work.
  Future<void> init();

  /// A [KeyValueDb] implementation may override this method to perform
  /// needed cleanup on close and dispose.
  Future<void> dispose();

  /// Get a `value` from the [KeyValueDb], using string `key` as its key.
  ///
  /// If `key` does not exist in the repository, return `defaultValue`.
  T get<T>(String key, T defaultValue);

  /// Put "save" a `value` in the [KeyValueDb] service, using `key` as its
  /// storage key.
  Future<void> put<T>(String key, T value);
}
