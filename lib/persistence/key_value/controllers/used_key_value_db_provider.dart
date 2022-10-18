import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/key_value_db.dart';
import '../models/used_key_value_db.dart';

/// A [StateProvider] controller used to control which [KeyValueDb]
/// implementation is used.
///
/// The controller is also used to change state of UI to select used
/// [KeyValueDb] implementation.
final StateProvider<UsedKeyValueDb> usedKeyValueDbProvider =
    StateProvider<UsedKeyValueDb>(
  (final StateProviderRef<UsedKeyValueDb> ref) => UsedKeyValueDb.hive,
  name: 'usedKeyValueDbProvider',
);
