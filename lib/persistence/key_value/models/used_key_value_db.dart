import '../../../core/constants/app_db.dart';
import 'key_value_db.dart';
import 'key_value_db_hive.dart';
import 'key_value_db_mem.dart';
import 'key_value_db_prefs.dart';

/// An enhanced enum used to select used [KeyValueDb] implementation.
enum UsedKeyValueDb {
  memory(),
  sharedPreferences(),
  hive(AppDb.keyValueFilename); // Used filename for Hive storage box.

  final String _filename;
  const UsedKeyValueDb([this._filename = '']);

  /// Get initialized [KeyValueDb] implementation based on enum value.
  // Future<KeyValueDb> get init async {
  KeyValueDb get get {
    switch (this) {
      case UsedKeyValueDb.memory:
        return KeyValueDbMem();
      case UsedKeyValueDb.sharedPreferences:
        return KeyValueDbPrefs();
      case UsedKeyValueDb.hive:
        return KeyValueDbHive(_filename);
    }
  }

  /// Get initialized [KeyValueDb] implementation based on enum value.
  // Future<KeyValueDb> get init async {
  String get describe {
    switch (this) {
      case UsedKeyValueDb.memory:
        return 'Memory';
      case UsedKeyValueDb.sharedPreferences:
        return 'Shared Preferences';
      case UsedKeyValueDb.hive:
        return 'Hive';
    }
  }
}
