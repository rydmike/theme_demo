import '../../persistence/key_value/models/key_value_db_prefs.dart';
import '../../persistence/key_value/models/used_key_value_db.dart';

// ignore_for_file: comment_references

/// App name and info constants.
class AppDb {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  AppDb._();

  /// Default used [KeyValueDb] implementation.
  static const UsedKeyValueDb keyValue = UsedKeyValueDb.hive;

  /// Used file name for the local [KeyValueDb].
  ///
  /// In this app only the Hive box [KeyValueDbHive] can use a user defined
  /// filename, the SharedPreferences packages and her the [KeyValueDbPrefs]
  /// used a fixed name for it local storage file.
  static const String keyValueFilename = 'settings_box';
}
