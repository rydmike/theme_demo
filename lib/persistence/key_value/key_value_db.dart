import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Abstract interface for the [KeyValueDb] used to read and save simple
/// key-value pairs.
abstract class KeyValueDb {
  /// A [KeyValueDb] implementation may override this method to perform
  /// needed initialization and setup work.
  Future<void> init();

  /// A [KeyValueDb] implementation may override this method to perform
  /// needed cleanup on close/dispose.
  Future<void> dispose();

  /// Get `value` from the [KeyValueDb], stored with `key` string.
  ///
  /// If `key` does not exist in the repository, returns `defaultValue`.
  T get<T>(String key, T defaultValue);

  /// Put a value to the [KeyValueDb] service, using `key` as its
  /// storage key.
  Future<void> put<T>(String key, T value);
}

/// A provider for the KeyValueRepository.
///
/// Returns null, we will need to override it with an initialized value before
/// we use it.
final Provider<KeyValueDb> keyValueDbProvider =
    Provider<KeyValueDb>((ProviderRef<KeyValueDb> ref) {
  throw UnimplementedError();
});
