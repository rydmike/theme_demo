import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../utils/app_data_dir/app_data_dir.dart';
import 'key_value_db.dart';

// Set the bool flag to true to show debug prints. Even if it is forgotten
// to set it to false, debug prints will not show in release builds.
// The handy part is that if it gets in the way in debugging, it is an easy
// toggle to turn it off here too. Often I just leave them true if it is one
// I want to see in dev mode, unless it is too chatty.
const bool _debug = !kReleaseMode && true;

/// A [KeyValueDb] implementation that stores and retrieves key-value
/// pairs locally using the package Hive: https://pub.dev/packages/hive
class KeyValueDbHive implements KeyValueDb {
  KeyValueDbHive(this.boxName);

  /// The name of the Hive storage box.
  ///
  /// This is the filename without any extension or path, to use for
  /// the Hive storage box, for example: 'my_app_settings'
  final String boxName;

  // Holds an instance to Hive box, must be initialized by the init call
  //before accessing the storage box.
  late final Box<dynamic> _hiveBox;

  /// [KeyValueDbHive]'s init implementation. Must be called before
  /// accessing the storage box.
  ///
  /// - Registers Hive data type adapters for our enum values
  /// - Gets a usable platform appropriate folder where data can be stored.
  /// - Open the box in the folder with name given via class constructor.
  /// - Assign box to local Hive box instance.
  @override
  Future<void> init() async {
    // First register all Hive data type adapters. Used for our enum values.
    _registerHiveAdapters();
    // Get platform compatible storage folder for the Hive box,
    // this setup should work on all Flutter platforms. Hive does not do this
    // right, the folder we got with it did not work on Windows. This
    // implementation works and it uses the same folder that SharedPreferences
    // does.
    final String appDataDir = await getAppDataDir();
    // To make it easier to find the files on your device, this should help.
    // Usually you find the "shared_preferences.json" file in the same folder
    // that the KeyValueDataSourcePrefs creates with SharedPreferences. You
    // cannot set the name on that file, but we can do it with Hive.
    if (!kReleaseMode) {
      debugPrint(
          'Hive using storage path: $appDataDir and file name: $boxName');
    }
    // Init the Hive box box giving it the platform usable folder.
    Hive.init(appDataDir);
    // Open the Hive box with passed in name, we just keep it open all the
    // time in this demo app.
    await Hive.openBox<dynamic>(boxName);
    // Assign the box to our instance.
    _hiveBox = Hive.box<dynamic>(boxName);
  }

  /// [KeyValueDbHive] implementation may close its box if so desired
  /// on close/dispose of app, but it is not strictly necessary according to
  /// Hive docs.
  @override
  Future<void> dispose() async {
    await _hiveBox.compact();
    await _hiveBox.close();
  }

  /// Register all custom Hive data adapters.
  void _registerHiveAdapters() {
    Hive.registerAdapter(ThemeModeAdapter());
    Hive.registerAdapter(ColorAdapter());
    Hive.registerAdapter(FlexSchemeAdapter());
    Hive.registerAdapter(FlexSurfaceModeAdapter());
    Hive.registerAdapter(FlexInputBorderTypeAdapter());
    Hive.registerAdapter(FlexTabBarStyleAdapter());
    Hive.registerAdapter(FlexAppBarStyleAdapter());
    Hive.registerAdapter(FlexSystemNavBarStyleAdapter());
    Hive.registerAdapter(FlexSchemeColorAdapter());
    Hive.registerAdapter(NavigationDestinationLabelBehaviorAdapter());
    Hive.registerAdapter(NavigationRailLabelTypeAdapter());
  }

  /// Load/get a setting from the [KeyValueDbHive], using a key to access
  /// it from the Hive storage box.
  ///
  /// If type <T> is not an atomic Dart type, there must be a
  /// Hive type adapter that converts <T> into one.
  @override
  T get<T>(String key, T defaultValue) {
    try {
      final T loaded = _hiveBox.get(key, defaultValue: defaultValue) as T;
      if (_debug) {
        debugPrint('Hive type   : $key as ${defaultValue.runtimeType}');
        debugPrint('Hive loaded : $key as $loaded with ${loaded.runtimeType}');
      }
      return loaded;
    } catch (e) {
      debugPrint('Hive load (get) ERROR');
      debugPrint(' Error message ...... : $e');
      debugPrint(' Store key .......... : $key');
      debugPrint(' defaultValue ....... : $defaultValue');
      // If something goes wrong we return the default value.
      return defaultValue;
    }
  }

  /// Save/put  a setting to the [KeyValueDbHive] with the Hive storage box,
  /// using key, as key for the value.
  ///
  /// If type <T> is not an atomic Dart type, there must be a
  /// Hive type adapter that converts <T> into one.
  @override
  Future<void> put<T>(String key, T value) async {
    try {
      await _hiveBox.put(key, value);
      if (_debug) {
        debugPrint('Hive type   : $key as ${value.runtimeType}');
        debugPrint('Hive saved  : $key as $value');
      }
    } catch (e) {
      debugPrint('Hive save (put) ERROR');
      debugPrint(' Error message ...... : $e');
      debugPrint(' Store key .......... : $key');
      debugPrint(' Save value ......... : $value');
    }
  }
}

/// A Hive data type adapter for enum [ThemeMode].
class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  ThemeMode read(BinaryReader reader) {
    final int index = reader.readInt();
    return ThemeMode.values[index];
  }

  @override
  void write(BinaryWriter writer, ThemeMode obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 150;
}

/// A Hive data type adapter for class [Color].
class ColorAdapter extends TypeAdapter<Color> {
  @override
  Color read(BinaryReader reader) {
    final int value = reader.readInt();
    return Color(value);
  }

  @override
  void write(BinaryWriter writer, Color obj) {
    writer.writeInt(obj.value);
  }

  @override
  int get typeId => 151;
}

/// A Hive data type adapter for enum [FlexScheme].
class FlexSchemeAdapter extends TypeAdapter<FlexScheme> {
  @override
  FlexScheme read(BinaryReader reader) {
    final int index = reader.readInt();
    return FlexScheme.values[index];
  }

  @override
  void write(BinaryWriter writer, FlexScheme obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 152;
}

/// A Hive data type adapter for enum [FlexSurfaceMode].
class FlexSurfaceModeAdapter extends TypeAdapter<FlexSurfaceMode> {
  @override
  FlexSurfaceMode read(BinaryReader reader) {
    final int index = reader.readInt();
    return FlexSurfaceMode.values[index];
  }

  @override
  void write(BinaryWriter writer, FlexSurfaceMode obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 153;
}

/// A Hive data type adapter for enum [FlexInputBorderType].
class FlexInputBorderTypeAdapter extends TypeAdapter<FlexInputBorderType> {
  @override
  FlexInputBorderType read(BinaryReader reader) {
    final int index = reader.readInt();
    return FlexInputBorderType.values[index];
  }

  @override
  void write(BinaryWriter writer, FlexInputBorderType obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 154;
}

/// A Hive data type adapter for enum [FlexAppBarStyle].
class FlexAppBarStyleAdapter extends TypeAdapter<FlexAppBarStyle> {
  @override
  FlexAppBarStyle read(BinaryReader reader) {
    final int index = reader.readInt();
    return FlexAppBarStyle.values[index];
  }

  @override
  void write(BinaryWriter writer, FlexAppBarStyle obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 155;
}

/// A Hive data type adapter for enum [FlexTabBarStyle].
class FlexTabBarStyleAdapter extends TypeAdapter<FlexTabBarStyle> {
  @override
  FlexTabBarStyle read(BinaryReader reader) {
    final int index = reader.readInt();
    return FlexTabBarStyle.values[index];
  }

  @override
  void write(BinaryWriter writer, FlexTabBarStyle obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 156;
}

/// A Hive data type adapter for enum [FlexSystemNavBarStyle].
class FlexSystemNavBarStyleAdapter extends TypeAdapter<FlexSystemNavBarStyle> {
  @override
  FlexSystemNavBarStyle read(BinaryReader reader) {
    final int index = reader.readInt();
    return FlexSystemNavBarStyle.values[index];
  }

  @override
  void write(BinaryWriter writer, FlexSystemNavBarStyle obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 157;
}

/// A Hive data type adapter for enum [SchemeColor], nullable.
///
/// Handles storing <null> value as -1 and returns anything out of enum
/// index range as null value.
class FlexSchemeColorAdapter extends TypeAdapter<SchemeColor?> {
  @override
  SchemeColor? read(BinaryReader reader) {
    final int index = reader.readInt();
    if (index < 0 || index >= SchemeColor.values.length) {
      return null;
    } else {
      return SchemeColor.values[index];
    }
  }

  @override
  void write(BinaryWriter writer, SchemeColor? obj) {
    writer.writeInt(obj?.index ?? -1);
  }

  @override
  int get typeId => 158;
}

/// A Hive data type adapter for enum [NavigationDestinationLabelBehavior].
class NavigationDestinationLabelBehaviorAdapter
    extends TypeAdapter<NavigationDestinationLabelBehavior> {
  @override
  NavigationDestinationLabelBehavior read(BinaryReader reader) {
    final int index = reader.readInt();
    return NavigationDestinationLabelBehavior.values[index];
  }

  @override
  void write(BinaryWriter writer, NavigationDestinationLabelBehavior obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 159;
}

/// A Hive data type adapter for enum [NavigationRailLabelType].
class NavigationRailLabelTypeAdapter
    extends TypeAdapter<NavigationRailLabelType> {
  @override
  NavigationRailLabelType read(BinaryReader reader) {
    final int index = reader.readInt();
    return NavigationRailLabelType.values[index];
  }

  @override
  void write(BinaryWriter writer, NavigationRailLabelType obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 160;
}
