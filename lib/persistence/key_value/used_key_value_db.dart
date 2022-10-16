import '../../constants/app_const.dart';
import 'key_value_db.dart';
import 'key_value_db_hive.dart';
import 'key_value_db_mem.dart';
import 'key_value_db_prefs.dart';

/// Enum used to select used [KeyValueDb] implementation.
enum UsedKeyValueDb {
  memory,
  sharedPreferences,
  hive,
}

/// Get used [KeyValueDb] implementation based on passed in enum value.
Future<KeyValueDb> usedKeyValueDb(UsedKeyValueDb db) async {
  switch (db) {
    case UsedKeyValueDb.memory:
      {
        final KeyValueDbMem keyValueDb = KeyValueDbMem();
        await keyValueDb.init();
        return keyValueDb;
      }
    case UsedKeyValueDb.sharedPreferences:
      {
        final KeyValueDbPrefs keyValueDb = KeyValueDbPrefs();
        await keyValueDb.init();
        return keyValueDb;
      }
    case UsedKeyValueDb.hive:
      {
        final KeyValueDbHive keyValueDb =
            KeyValueDbHive(AppConst.keyValueFilename);
        await keyValueDb.init();
        return keyValueDb;
      }
  }
}
