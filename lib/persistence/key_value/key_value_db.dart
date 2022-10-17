import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_const.dart';
import 'key_value_db_hive.dart';

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

// TODO(rydmike): Clean up experimental code.

/// A provider for the KeyValueRepository.
///
/// Returns null, we will need to override it with an initialized value before
/// we use it.
final Provider<KeyValueDb> keyValueDbProvider =
    Provider<KeyValueDb>((ProviderRef<KeyValueDb> ref) {
  // final KeyValueDb db = ref.watch(usedKeyValueDbProvider).get;
  // ref.onDispose(db.dispose);
  // return ref.watch(usedKeyValueDbProvider).get;
  // throw UnimplementedError();
  return KeyValueDbHive(AppConst.keyValueFilename);
});

// final AutoDisposeProvider<KeyValueDb> keyValueDbProvider =
//     Provider.autoDispose<KeyValueDb>((AutoDisposeProviderRef<KeyValueDb> ref) {
//   final KeyValueDb db = ref.watch(usedKeyValueDbProvider).get;
//   ref.onDispose(db.dispose);
//   return ref.watch(usedKeyValueDbProvider).get;
//   // throw UnimplementedError();
// });

// final AutoDisposeFutureProvider<KeyValueDb> keyValueDbFutureProvider =
//     FutureProvider.autoDispose<KeyValueDb>(
//         (AutoDisposeFutureProviderRef<KeyValueDb> ref) {
//   final KeyValueDb db = ref.watch(keyValueDbProvider);
//   db.init();
//   return db;
// });

// /// A provider for the KeyValueRepository.
// ///
// /// Returns null, we will need to override it with an initialized value before
// /// we use it.
// final AutoDisposeFutureProvider<KeyValueDb> futureKeyValueDbProvider =
// FutureProvider.autoDispose<KeyValueDb>(
//         (FutureProviderRef<KeyValueDb> ref) async {
//       return ref.watch(usedKeyValueDbProvider).init;
//     });
//
// final Provider<KeyValueDb> keyValueDbProvider =
// Provider<KeyValueDb>((ProviderRef<KeyValueDb> ref) {
//   final future = ref.watch(futureKeyValueDbProvider);
//   if (future.hasValue) {
//     return future.value!;
//   } else {
//     return KeyValueDbMem();
//   }
// });
