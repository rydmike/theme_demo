import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// Constants used as key values for storing, ie persisting all the
/// settings and options used in in the app.
class KeyValue {
  // This class is not meant to be instantiated or extended, this constructor
  // prevents external instantiation and extension.
  KeyValue._();

  // Key for storing the last used theme mode.
  static const String keyThemeMode = 'themeMode';
  static const ThemeMode defaultThemeMode = ThemeMode.system;

  // Keys for storing FlexColorScheme theme settings index.
  static const String keySchemeIndex = 'schemeIndex';
  static const int defaultSchemeIndex = 0;

  static const String keyLightSurfaceMode = 'lightSurfaceMode';
  static const FlexSurfaceMode defaultLightSurfaceMode =
      FlexSurfaceMode.highSurfaceLowScaffold;

  static const String keyLightBlendLevel = 'lightBlendLevel';
  static const int defaultLightBlendLevel = 10;

  static const String keyDarkSurfaceMode = 'darkSurfaceMode';
  static const FlexSurfaceMode defaultDarkSurfaceMode =
      FlexSurfaceMode.highScaffoldLowSurface;

  static const String keyDarkBlendLevel = 'darkBlendLevel';
  static const int defaultDarkBlendLevel = 15;

  static const String keyLightAppBarStyle = 'lightAppBarStyle';
  static const FlexAppBarStyle defaultLightAppBarStyle =
      FlexAppBarStyle.primary;

  static const String keyLightSwapColors = 'lightSwapColors';
  static const bool defaultLightSwapColors = false;

  static const String keyDarkAppBarStyle = 'darkAppBarStyle';
  static const FlexAppBarStyle defaultDarkAppBarStyle =
      FlexAppBarStyle.background;

  static const String keyDarkSwapColors = 'darkSwapColors';
  static const bool defaultDarkSwapColors = false;

  static const String keyAppBarElevation = 'appBarElevation';
  static const double defaultAppBarElevation = 0.0;

  static const String keyComputeDarkTheme = 'computeDarkTheme';
  static const bool defaultComputeDarkTheme = false;

  static const String keyDarkLevel = 'darkLevel';
  static const int defaultDarkLevel = 35;

  static const String keyDarkIsTrueBlack = 'darkIsTrueBlack';
  static const bool defaultDarkIsTrueBlack = false;
}
