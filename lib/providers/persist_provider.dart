import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef PersistReader<T> = T? Function(Ref);
typedef PersistWriter<T> = void Function(T) Function(Ref);
typedef PersistCreate<P extends ProviderBase<dynamic>, T> = P Function(
  PersistReader<T> read,
  PersistWriter<T> write,
);

P persistProvider<P extends ProviderBase<dynamic>, T>(
  PersistCreate<P, T> create, {
  required Storage<T> Function(Ref ref) buildStorage,
}) {
  final Provider<Storage<T>> storageProvider =
      Provider<Storage<T>>(buildStorage);

  T? read(Ref ref) => ref.read(storageProvider).get();
  void Function(T item) write(Ref ref) => ref.watch(storageProvider).set;

  return create(read, write);
}

// P persistProvider<P extends ProviderBase, T>(
//   PersistCreate<P, T> create, {
//   required Storage<T> Function(Ref ref) buildStorage,
// }) {
//   final Provider<Storage<T>> storageProvider =
//       Provider<Storage<T>>(buildStorage);

//   T? read(Ref ref) => ref.read(storageProvider).get();
//   void Function(T item) write(Ref ref) => ref.watch(storageProvider).set;

//   return create(read, write);
// }

// typedef ToJson<T> = dynamic Function(T item);
// typedef FromJson<T> = T Function(dynamic json);

abstract class Storage<T> {
  T? get();
  void set(T item);
}

// class SharedPreferencesStorage<T> implements Storage<T> {
//   const SharedPreferencesStorage({
//     required String key,
//     required this.toJson,
//     required this.fromJson,
//     required this.instance,
//     String keyPrefix = 'rp_persist_',
//   }) : _key = '$keyPrefix$key';

//   final String _key;
//   final ToJson<T> toJson;
//   final FromJson<T> fromJson;
//   final SharedPreferences instance;

//   @override
//   T? get() => O
//       .fromNullable(instance.getString(_key))
//       .p(O.chainNullableK(json.decode))
//       .p(O.map(fromJson))
//       .p(O.toNullable);

//   @override
//   void set(item) {
//     instance.setString(_key, json.encode(toJson(item)));
//   }
// }
