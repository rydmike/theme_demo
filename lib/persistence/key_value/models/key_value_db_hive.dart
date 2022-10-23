import 'dart:async';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../core/utils/app_data_dir/app_data_dir_vm.dart';
import 'key_value_db.dart';

// Set the bool flag to true to show debug prints. Even if you forgot
// to set it to false, debug prints will not show in release builds.
// The handy part is that if it gets in the way in debugging, it is an easy
// toggle to turn it off here for just this feature. You can leave it true
// below to see this feature's logs in debug mode.
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

  // Is true if KeyValueDbHive has already been initialized, if it has
  // and init() is called again, init() it does nothing.
  bool _isInitialized = false;

  /// [KeyValueDbHive]'s init implementation. Must be called before
  /// accessing the storage box.
  ///
  /// - Registers Hive data type adapters for our enum values
  /// - Gets a usable platform appropriate folder where data can be stored.
  /// - Open the box in the folder with name given via class constructor.
  /// - Assign box to local Hive box instance.
  @override
  Future<void> init() async {
    if (_debug) {
      debugPrint(
          'KeyValueDbHive: init called, _isInitialized = $_isInitialized');
    }

    // If init has already been called exit with no-op.
    if (_isInitialized) return;

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
    if (_debug) {
      debugPrint(
          'KeyValueDbHive storage path: $appDataDir and file name: $boxName');
    }
    // Init the Hive box box giving it the platform usable folder.
    Hive.init(appDataDir);
    // Open the Hive box with passed in name, we just keep it open all the
    // time in this demo app.
    await Hive.openBox<dynamic>(boxName);
    // Assign the box to our instance.
    _hiveBox = Hive.box<dynamic>(boxName);

    // Set _isInitialized to true.
    _isInitialized = true;
  }

  /// [KeyValueDbHive] implementation may close its box if so desired
  /// on close/dispose of app, but it is not strictly necessary according to
  /// Hive docs.
  @override
  Future<void> dispose() async {
    if (_debug) debugPrint('KeyValueDbHive: disposed');
    await _hiveBox.compact();
    await _hiveBox.close();
    // Set _isInitialized to false.
    _isInitialized = false;
  }

  /// Register all custom Hive data adapters.
  ///
  /// Don't change the adapter TypeIDs below. If you do make sure to delete
  /// the Hive storage box and start from a new one.
  void _registerHiveAdapters() {
    _safeRegisterAdapter(150, ThemeModeAdapter(150));
    _safeRegisterAdapter(151, ColorAdapter(151));
    _safeRegisterAdapter(152, FlexSchemeAdapter(152));
    _safeRegisterAdapter(153, FlexSurfaceModeAdapter(153));
    _safeRegisterAdapter(154, FlexInputBorderTypeAdapter(154));
    _safeRegisterAdapter(155, FlexAppBarStyleAdapter(155));
    _safeRegisterAdapter(156, FlexTabBarStyleAdapter(156));
    _safeRegisterAdapter(157, FlexSystemNavBarStyleAdapter(157));
    _safeRegisterAdapter(158, FlexSchemeColorAdapter(158));
    _safeRegisterAdapter(159, NavigationDestinationLabelBehaviorAdapter(159));
    _safeRegisterAdapter(160, NavigationRailLabelTypeAdapter(160));
  }

  /// Hive keeps registered type adapters in a singleton that is not
  /// released even if we close the box. For it not to throw if we init it
  /// again, we check if the adapter ID we plan to use is already registered.
  /// If it is, we skip registration. We could also use
  /// Hive.registerAdapter(adapter, override: true), but it also screams
  /// an ugly long warning in the console. This gets around both cases.
  void _safeRegisterAdapter<T>(
    int typeId,
    TypeAdapter<T> adapter,
  ) {
    if (Hive.isAdapterRegistered(typeId)) return;
    Hive.registerAdapter(adapter);
  }

  /// Load/get a setting from the [KeyValueDbHive], using a key to access
  /// it from the Hive storage box.
  ///
  /// If type <T> is not an atomic Dart type, there must be a
  /// Hive type adapter that converts <T> into one.
  @override
  T get<T>(String key, T defaultValue) {
    try {
      final T value = _hiveBox.get(key, defaultValue: defaultValue) as T;
      if (_debug) {
        debugPrint('Hive get    : ["$key"] = $value (${value.runtimeType})');
      }
      return value;
    } catch (e) {
      debugPrint('Hive get (load) ERROR');
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
  Future<void> put<T>(String key, T value) {
    try {
      if (_debug) {
        debugPrint('Hive put    : ["$key"] = $value (${value.runtimeType})');
      }
      return _hiveBox.put(key, value);
    } catch (e) {
      debugPrint('Hive put (save) ERROR');
      debugPrint(' Error message ...... : $e');
      debugPrint(' Store key .......... : $key');
      debugPrint(' Save value ......... : $value');
      rethrow;
    }
  }
}

/// A Hive data type adapter for enum [ThemeMode].
class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  ThemeModeAdapter(this.id);
  final int id;

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
  int get typeId => id;
}

/// A Hive data type adapter for class [Color].
class ColorAdapter extends TypeAdapter<Color> {
  ColorAdapter(this.id);
  final int id;

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
  int get typeId => id;
}

/// A Hive data type adapter for enum [FlexScheme].
class FlexSchemeAdapter extends TypeAdapter<FlexScheme> {
  FlexSchemeAdapter(this.id);
  final int id;

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
  int get typeId => id;
}

/// A Hive data type adapter for enum [FlexSurfaceMode].
class FlexSurfaceModeAdapter extends TypeAdapter<FlexSurfaceMode> {
  FlexSurfaceModeAdapter(this.id);
  final int id;

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
  int get typeId => id;
}

/// A Hive data type adapter for enum [FlexInputBorderType].
class FlexInputBorderTypeAdapter extends TypeAdapter<FlexInputBorderType> {
  FlexInputBorderTypeAdapter(this.id);
  final int id;

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
  int get typeId => id;
}

/// A Hive data type adapter for enum [FlexAppBarStyle].
class FlexAppBarStyleAdapter extends TypeAdapter<FlexAppBarStyle> {
  FlexAppBarStyleAdapter(this.id);
  final int id;

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
  int get typeId => id;
}

/// A Hive data type adapter for enum [FlexTabBarStyle].
class FlexTabBarStyleAdapter extends TypeAdapter<FlexTabBarStyle> {
  FlexTabBarStyleAdapter(this.id);
  final int id;

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
  int get typeId => id;
}

/// A Hive data type adapter for enum [FlexSystemNavBarStyle].
class FlexSystemNavBarStyleAdapter extends TypeAdapter<FlexSystemNavBarStyle> {
  FlexSystemNavBarStyleAdapter(this.id);
  final int id;

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
  int get typeId => id;
}

/// A Hive data type adapter for enum [SchemeColor], nullable.
///
/// Handles storing <null> value as -1 and returns anything out of enum
/// index range as null value.
class FlexSchemeColorAdapter extends TypeAdapter<SchemeColor?> {
  FlexSchemeColorAdapter(this.id);
  final int id;

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
  int get typeId => id;
}

/// A Hive data type adapter for enum [NavigationDestinationLabelBehavior].
class NavigationDestinationLabelBehaviorAdapter
    extends TypeAdapter<NavigationDestinationLabelBehavior> {
  NavigationDestinationLabelBehaviorAdapter(this.id);
  final int id;

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
  int get typeId => id;
}

/// A Hive data type adapter for enum [NavigationRailLabelType].
class NavigationRailLabelTypeAdapter
    extends TypeAdapter<NavigationRailLabelType> {
  NavigationRailLabelTypeAdapter(this.id);
  final int id;

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
  int get typeId => id;
}
