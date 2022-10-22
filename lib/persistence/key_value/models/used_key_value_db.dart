import '../../../core/constants/app_db.dart';
import 'key_value_db.dart';
import 'key_value_db_hive.dart';
import 'key_value_db_mem.dart';
import 'key_value_db_prefs.dart';

/// An enhanced enum used to represent, select and describe the used
/// [KeyValueDb] implementation.
enum UsedKeyValueDb {
  memory(),
  sharedPreferences(),
  hive(AppDb.keyValueFilename); // Used filename for the Hive storage box.

  final String _filename;
  const UsedKeyValueDb([this._filename = '']);

  /// Get the [KeyValueDb] implementation corresponding to the enum value.
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

  /// Describe the [KeyValueDb] implementation corresponding to the enum value.
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
