import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/settings_entry.dart';

// Set the bool flag to true to show debug prints. Even if you forgot
// to set it to false, debug prints will not show in release builds.
// The handy part is that if it gets in the way in debugging, it is an easy
// toggle to turn it off here too for just this feature. You can leave it true
// below to see this features logs in debug mode.
const bool _debug = !kReleaseMode && true;

class Settings {
  // This constructor prevents external instantiation and extension.
  Settings._();

  // Default values for all the settings entries.
  // They are collected here at the top to be easy to modify.
  //
  // Use material 3, theme mode and active color scheme.
  static const bool _useMaterial3 = false;
  static const ThemeMode _themeMode = ThemeMode.system;
  static const int _schemeIndex = 0;
  // Surface mode defaults
  static const FlexSurfaceMode _lightSurfaceMode =
      FlexSurfaceMode.highSurfaceLowScaffold;
  static const FlexSurfaceMode _darkSurfaceMode =
      FlexSurfaceMode.highScaffoldLowSurface;
  // surface blend level defaults
  static const int _lightBlendLevel = 10;
  static const int _darkBlendLevel = 15;
  // Swap primary and secondary colors.
  static const bool _lightSwapColors = false;
  static const bool _darkSwapColors = false;
  // AppBar elevation and color defaults.
  static const double _appBarElevation = 0.0;
  static const FlexAppBarStyle _lightAppBarStyle = FlexAppBarStyle.primary;
  static const FlexAppBarStyle _darkAppBarStyle = FlexAppBarStyle.background;
  // AppBar opacity and scrim
  static const bool _transparentStatusBar = false;
  static const double _lightAppBarOpacity = 0.95;
  static const double _darkAppBarOpacity = 0.91;
  // Dark theme only extra settings, like computed dark theme and true black.
  static const bool _darkIsTrueBlack = false;
  static const bool _darkComputeTheme = false;
  static const int _darkComputeLevel = 25;

  /// Rest all settings entries and their controllers to default values.
  ///
  /// This action is triggered by the user.
  static void resetAll(WidgetRef ref) {
    if (_debug) debugPrint('Settings: resetAll DB values');
    // Use material 3, theme mode and active color scheme.
    ref.read(useMaterial3Provider.notifier).reset();
    ref.read(themeModeProvider.notifier).reset();
    ref.read(schemeIndexProvider.notifier).reset();
    // Surface mode.
    ref.read(lightSurfaceModeProvider.notifier).reset();
    ref.read(darkSurfaceModeProvider.notifier).reset();
    // Surface blend levels.
    ref.read(lightBlendLevelProvider.notifier).reset();
    ref.read(darkBlendLevelProvider.notifier).reset();
    // Swap primary and secondary colors.
    ref.read(lightSwapColorsProvider.notifier).reset();
    ref.read(darkSwapColorsProvider.notifier).reset();
    // AppBar elevation and color.
    ref.read(appBarElevationProvider.notifier).reset();
    ref.read(lightAppBarStyleProvider.notifier).reset();
    ref.read(darkAppBarStyleProvider.notifier).reset();
    // AppBar transparent status bar scrim in Android and opacity.
    ref.read(transparentStatusBarProvider.notifier).reset();
    ref.read(lightAppBarOpacityProvider.notifier).reset();
    ref.read(darkAppBarOpacityProvider.notifier).reset();
    // Dark theme only extra settings, like computed dark theme and true black.
    ref.read(darkIsTrueBlackProvider.notifier).reset();
    ref.read(darkComputeThemeProvider.notifier).reset();
    ref.read(darkComputeLevelProvider.notifier).reset();
  }

  /// Set all settings entries and their controllers to values from DB.
  ///
  /// This is typically only used when switching DB implementation dynamically.
  static void getAll(Ref ref) {
    if (_debug) debugPrint('Settings: getAll DB values');
    // Use material 3, theme mode and active color scheme.
    ref.read(useMaterial3Provider.notifier).get();
    ref.read(themeModeProvider.notifier).get();
    ref.read(schemeIndexProvider.notifier).get();
    // Surface mode.
    ref.read(lightSurfaceModeProvider.notifier).get();
    ref.read(darkSurfaceModeProvider.notifier).get();
    // Surface blend levels.
    ref.read(lightBlendLevelProvider.notifier).get();
    ref.read(darkBlendLevelProvider.notifier).get();
    // Swap primary and secondary colors.
    ref.read(lightSwapColorsProvider.notifier).get();
    ref.read(darkSwapColorsProvider.notifier).get();
    // AppBar elevation and color.
    ref.read(appBarElevationProvider.notifier).get();
    ref.read(lightAppBarStyleProvider.notifier).get();
    ref.read(darkAppBarStyleProvider.notifier).get();
    // AppBar transparent status bar scrim in Android and opacity.
    ref.read(transparentStatusBarProvider.notifier).get();
    ref.read(lightAppBarOpacityProvider.notifier).get();
    ref.read(darkAppBarOpacityProvider.notifier).get();
    // Dark theme only extra settings, like computed dark theme and true black.
    ref.read(darkIsTrueBlackProvider.notifier).get();
    ref.read(darkComputeThemeProvider.notifier).get();
    ref.read(darkComputeLevelProvider.notifier).get();
  }

  /// String key used for defining if we use Material 3 or Material 2.
  ///
  /// The associated provider uses same name with "Provider" added to it.
  static const String _keyUseMaterial3 = 'useMaterial3';

  /// Provider for swapping primary and secondary colors in light theme mode.
  ///
  /// Defaults to [_useMaterial3].
  static final StateNotifierProvider<SettingsEntry<bool>, bool>
      useMaterial3Provider = StateNotifierProvider<SettingsEntry<bool>, bool>(
    (StateNotifierProviderRef<SettingsEntry<bool>, bool> ref) {
      return SettingsEntry<bool>(
        ref,
        defaultValue: _useMaterial3,
        key: _keyUseMaterial3,
      );
    },
    // Use the unique key-value DB key as provider name, useful for debugging.
    name: '${_keyUseMaterial3}Provider',
  );

  /// String key used for storing the last used app theme mode.
  ///
  /// The associated provider uses same name with "Provider" added to it.
  static const String _keyThemeMode = 'themeMode';

  /// The themeModeProvider represents a [StateProvider] to provide the state of
  /// the [ThemeMode], so to be able to toggle the application wide theme mode.
  ///
  /// Default to [_themeMode].
  static final StateNotifierProvider<SettingsEntry<ThemeMode>, ThemeMode>
      themeModeProvider =
      StateNotifierProvider<SettingsEntry<ThemeMode>, ThemeMode>(
    (StateNotifierProviderRef<SettingsEntry<ThemeMode>, ThemeMode> ref) {
      return SettingsEntry<ThemeMode>(
        ref,
        defaultValue: _themeMode,
        key: _keyThemeMode,
      );
    },
    name: '${_keyThemeMode}Provider',
  );

  /// String key for storing theme settings index.
  ///
  /// The associated provider uses same name with "Provider" added to it.
  static const String _keySchemeIndex = 'schemeIndex';

  /// The index provider of the currently used color scheme and theme.
  ///
  /// Defaults to first color scheme index: [_schemeIndex].
  static final StateNotifierProvider<SettingsEntry<int>, int>
      schemeIndexProvider = StateNotifierProvider<SettingsEntry<int>, int>(
    (StateNotifierProviderRef<SettingsEntry<int>, int> ref) {
      return SettingsEntry<int>(
        ref,
        defaultValue: _schemeIndex,
        key: _keySchemeIndex,
      );
    },
    // Use the unique key-value DB key as provider name, useful for debugging.
    name: '${_keySchemeIndex}Provider',
  );

  /// String key for storing used light theme surface mode.
  ///
  /// The associated provider uses same name with "Provider" added to it.
  static const String _keyLightSurfaceMode = 'lightSurfaceMode';

  /// The primary colored light surface branding mode provider.
  ///
  /// Defaults to [_lightSurfaceMode].
  static final StateNotifierProvider<SettingsEntry<FlexSurfaceMode>,
          FlexSurfaceMode> lightSurfaceModeProvider =
      StateNotifierProvider<SettingsEntry<FlexSurfaceMode>, FlexSurfaceMode>(
    (StateNotifierProviderRef<SettingsEntry<FlexSurfaceMode>, FlexSurfaceMode>
        ref) {
      return SettingsEntry<FlexSurfaceMode>(
        ref,
        defaultValue: _lightSurfaceMode,
        key: _keyLightSurfaceMode,
      );
    },
    // Use the unique key-value DB key as provider name, useful for debugging.
    name: '${_keyLightSurfaceMode}Provider',
  );

  /// String key used for storing light theme surface mode.
  ///
  /// The associated provider uses same name with "Provider" added to it.
  static const String _keyDarkSurfaceMode = 'darkSurfaceMode';

  /// The primary colored dark surface branding mode provider.
  ///
  /// Defaults to [_darkSurfaceMode].
  static final StateNotifierProvider<SettingsEntry<FlexSurfaceMode>,
          FlexSurfaceMode> darkSurfaceModeProvider =
      StateNotifierProvider<SettingsEntry<FlexSurfaceMode>, FlexSurfaceMode>(
    (StateNotifierProviderRef<SettingsEntry<FlexSurfaceMode>, FlexSurfaceMode>
        ref) {
      return SettingsEntry<FlexSurfaceMode>(
        ref,
        defaultValue: _darkSurfaceMode,
        key: _keyDarkSurfaceMode,
      );
    },
    // Use the unique key-value DB key as provider name, useful for debugging.
    name: '${_keyDarkSurfaceMode}Provider',
  );

  /// The primary colored light surface branding mode provider.
  ///
  /// Defaults to FlexSurfaceMode.highSurfaceLowScaffold.
  static const String _keyLightBlendLevel = 'lightBlendLevel';

  /// Provider for the strength of the blend level used by light surface mode.
  ///
  /// Defaults to [_lightBlendLevel].
  static final StateNotifierProvider<SettingsEntry<int>, int>
      lightBlendLevelProvider = StateNotifierProvider<SettingsEntry<int>, int>(
    (StateNotifierProviderRef<SettingsEntry<int>, int> ref) {
      return SettingsEntry<int>(
        ref,
        defaultValue: _lightBlendLevel,
        key: _keyLightBlendLevel,
      );
    },
    // Use the unique key-value DB key as provider name, useful for debugging.
    name: '${_keyLightBlendLevel}Provider',
  );

  /// Provider for the strength of the blend level used by dark surface mode.
  ///
  /// The associated provider uses same name with "Provider" added to it.
  static const String _keyDarkBlendLevel = 'darkBlendLevel';

  /// Provider for the strength of the blend level used by dark surface mode.
  ///
  /// Defaults to [_darkBlendLevel].
  static final StateNotifierProvider<SettingsEntry<int>, int>
      darkBlendLevelProvider = StateNotifierProvider<SettingsEntry<int>, int>(
    (StateNotifierProviderRef<SettingsEntry<int>, int> ref) {
      return SettingsEntry<int>(
        ref,
        defaultValue: _darkBlendLevel,
        key: _keyDarkBlendLevel,
      );
    },
    // Use the unique key-value DB key as provider name, useful for debugging.
    name: '${_keyDarkBlendLevel}Provider',
  );

  /// String key used for storing light mode primary/secondary color swap.
  ///
  /// The associated provider uses same name with "Provider" added to it.
  static const String _keyLightSwapColors = 'lightSwapColors';

  /// Provider for swapping primary and secondary colors in light theme mode.
  ///
  /// Defaults to [_lightSwapColors].
  static final StateNotifierProvider<SettingsEntry<bool>, bool>
      lightSwapColorsProvider =
      StateNotifierProvider<SettingsEntry<bool>, bool>(
    (StateNotifierProviderRef<SettingsEntry<bool>, bool> ref) {
      return SettingsEntry<bool>(
        ref,
        defaultValue: _lightSwapColors,
        key: _keyLightSwapColors,
      );
    },
    // Use the unique key-value DB key as provider name, useful for debugging.
    name: '${_keyLightSwapColors}Provider',
  );

  /// String key used for storing dark mode primary/secondary color swap.
  ///
  /// The associated provider uses same name with "Provider" added to it.
  static const String _keyDarkSwapColors = 'darkSwapColors';

  /// Provider for swapping primary and secondary colors in dark theme mode.
  ///
  /// Defaults to [_darkSwapColors].
  static final StateNotifierProvider<SettingsEntry<bool>, bool>
      darkSwapColorsProvider = StateNotifierProvider<SettingsEntry<bool>, bool>(
    (StateNotifierProviderRef<SettingsEntry<bool>, bool> ref) {
      return SettingsEntry<bool>(
        ref,
        defaultValue: _darkSwapColors,
        key: _keyDarkSwapColors,
      );
    },
    // Use the unique key-value DB key as provider name, useful for debugging.
    name: '${_keyDarkSwapColors}Provider',
  );

  /// String key used for storing the [AppBar] elevation.
  ///
  /// The associated provider uses same name with "Provider" added to it.
  static const String _keyAppBarElevation = 'appBarElevation';

  /// Provider for the elevation level used on the AppBar theme.
  ///
  /// Defaults to [_appBarElevation].
  static final StateNotifierProvider<SettingsEntry<double>, double>
      appBarElevationProvider =
      StateNotifierProvider<SettingsEntry<double>, double>(
    (StateNotifierProviderRef<SettingsEntry<double>, double> ref) {
      return SettingsEntry<double>(
        ref,
        defaultValue: _appBarElevation,
        key: _keyAppBarElevation,
      );
    },
    // Use the unique key-value DB key as provider name, useful for debugging.
    name: '${_keyAppBarElevation}Provider',
  );

  /// String key used for storing [AppBar] style in light theme mode.
  ///
  /// The associated provider uses same name with "Provider" added to it.
  static const String _keyLightAppBarStyle = 'lightAppBarStyle';

  /// The themed style of the light theme mode [AppBar].
  ///
  /// Defaults to [_lightAppBarStyle].
  /// Primary color is the default for Material 2 apps.
  static final StateNotifierProvider<SettingsEntry<FlexAppBarStyle?>,
          FlexAppBarStyle?> lightAppBarStyleProvider =
      StateNotifierProvider<SettingsEntry<FlexAppBarStyle?>, FlexAppBarStyle?>(
    (StateNotifierProviderRef<SettingsEntry<FlexAppBarStyle?>, FlexAppBarStyle?>
        ref) {
      return SettingsEntry<FlexAppBarStyle?>(
        ref,
        defaultValue: _lightAppBarStyle,
        key: _keyLightAppBarStyle,
      );
    },
    // Use the unique key-value DB key as provider name, useful for debugging.
    name: '${_keyLightAppBarStyle}Provider',
  );

  /// The themed style of the dark theme mode [AppBar].
  ///
  /// The associated provider uses same name with "Provider" added to it.
  static const String _keyDarkAppBarStyle = 'darkAppBarStyle';

  /// The themed style of the dark theme mode AppBar.
  ///
  /// Defaults to [_darkAppBarStyle].
  /// The default for Material 2 apps is [FlexAppBarStyle.material], which uses
  /// the Material background color  for active theme mode. The used default
  /// here [FlexAppBarStyle.background] is the background color that gets
  /// primary color branding based on the current [FlexSurfaceMode] setting.
  static final StateNotifierProvider<SettingsEntry<FlexAppBarStyle?>,
          FlexAppBarStyle?> darkAppBarStyleProvider =
      StateNotifierProvider<SettingsEntry<FlexAppBarStyle?>, FlexAppBarStyle?>(
    (StateNotifierProviderRef<SettingsEntry<FlexAppBarStyle?>, FlexAppBarStyle?>
        ref) {
      return SettingsEntry<FlexAppBarStyle?>(
        ref,
        defaultValue: _darkAppBarStyle,
        key: _keyDarkAppBarStyle,
      );
    },
    // Use the unique key-value DB key as provider name, useful for debugging.
    name: '${_keyDarkAppBarStyle}Provider',
  );

  /// String key used for storing android app bar scrim usage.
  ///
  /// The associated provider uses same name with "Provider" added to it.
  static const String _keyTransparentStatusBar = 'transparentStatusBar';

  /// Provider for swapping primary and secondary colors in dark theme mode.
  ///
  /// Defaults to [_transparentStatusBar].
  static final StateNotifierProvider<SettingsEntry<bool>, bool>
      transparentStatusBarProvider =
      StateNotifierProvider<SettingsEntry<bool>, bool>(
    (StateNotifierProviderRef<SettingsEntry<bool>, bool> ref) {
      return SettingsEntry<bool>(
        ref,
        defaultValue: _transparentStatusBar,
        key: _keyTransparentStatusBar,
      );
    },
    // Use the unique key-value DB key as provider name, useful for debugging.
    name: '${_keyTransparentStatusBar}Provider',
  );

  /// String key used for storing the light mode [AppBar] opacity.
  ///
  /// The associated provider uses same name with "Provider" added to it.
  static const String _keyLightAppBarOpacity = 'lightAppBarOpacity';

  /// Provider for the light [AppBar] opacity.
  ///
  /// Defaults to [_lightAppBarOpacity].
  static final StateNotifierProvider<SettingsEntry<double>, double>
      lightAppBarOpacityProvider =
      StateNotifierProvider<SettingsEntry<double>, double>(
    (StateNotifierProviderRef<SettingsEntry<double>, double> ref) {
      return SettingsEntry<double>(
        ref,
        defaultValue: _lightAppBarOpacity,
        key: _keyLightAppBarOpacity,
      );
    },
    // Use the unique key-value DB key as provider name, useful for debugging.
    name: '${_keyLightAppBarOpacity}Provider',
  );

  /// String key used for storing the light mode [AppBar] opacity.
  ///
  /// The associated provider uses same name with "Provider" added to it.
  static const String _keyDarkAppBarOpacity = 'darkAppBarOpacity';

  /// Provider for the dark [AppBar] opacity.
  ///
  /// Defaults to [_darkAppBarOpacity].
  static final StateNotifierProvider<SettingsEntry<double>, double>
      darkAppBarOpacityProvider =
      StateNotifierProvider<SettingsEntry<double>, double>(
    (StateNotifierProviderRef<SettingsEntry<double>, double> ref) {
      return SettingsEntry<double>(
        ref,
        defaultValue: _darkAppBarOpacity,
        key: _keyDarkAppBarOpacity,
      );
    },
    // Use the unique key-value DB key as provider name, useful for debugging.
    name: '${_keyDarkAppBarOpacity}Provider',
  );

  /// String key used for storing bool to define if we use computed dark theme.
  ///
  /// The associated provider uses same name with "Provider" added to it.
  static const String _keyDarkComputeTheme = 'darkComputeTheme';

  /// Provider for using true black, instead of normal dark, in dark theme mode.
  ///
  /// Defaults to [_darkIsTrueBlack].
  static final StateNotifierProvider<SettingsEntry<bool>, bool>
      darkIsTrueBlackProvider =
      StateNotifierProvider<SettingsEntry<bool>, bool>(
    (StateNotifierProviderRef<SettingsEntry<bool>, bool> ref) {
      return SettingsEntry<bool>(
        ref,
        defaultValue: _darkIsTrueBlack,
        key: _keyDarkIsTrueBlack,
      );
    },
    // Use the unique key-value DB key as provider name, useful for debugging.
    name: '${_keyDarkIsTrueBlack}Provider',
  );

  /// Option to use dark scheme calculation from light scheme colors, instead
  /// of using the pre-defined dark scheme colors.
  ///
  /// Default to [_darkComputeTheme].
  ///
  /// This can be used use if you want to try to find colors based on your light
  /// scheme colors, then use this mode and adjust the saturation level, when
  /// you find colors that work well visually you can pick them with a picker
  /// and change your defined dark colors to those picked color values instead.
  ///
  /// Handy for making a tuned dark scheme based on light scheme colors. You
  /// can also use the principle shown here as a way to make just computed dark
  /// themes from light scheme color definitions, just pick a saturation level
  /// that you think work well enough and use that as the dark scheme color
  /// input instead. There is an example of this in the FlexColorScheme package
  /// tutorial as well.
  static final StateNotifierProvider<SettingsEntry<bool>, bool>
      darkComputeThemeProvider =
      StateNotifierProvider<SettingsEntry<bool>, bool>(
    (StateNotifierProviderRef<SettingsEntry<bool>, bool> ref) {
      return SettingsEntry<bool>(
        ref,
        defaultValue: _darkComputeTheme,
        key: _keyDarkComputeTheme,
      );
    },
    // Use the unique key-value DB key as provider name, useful for debugging.
    name: '${_keyDarkComputeTheme}Provider',
  );

  /// String key used for storing dark saturation level for computed dark theme.
  ///
  /// The associated provider uses same name with "Provider" added to it.
  static const String _keyDarkComputeLevel = 'darkComputeLevel';

  /// Dark scheme brightness level provider, used for adjusting the color
  /// saturation of the dark color scheme calculated from light scheme.
  ///
  /// Value 0% results in same colors as light theme color scheme, value 100%
  /// results in no colors, a black and white grey scale theme. Values between
  /// 15%...40% usually produce decent looking dark color scheme from the used
  /// light scheme colors. What works best depends on how saturated the light
  /// scheme colors are, and personal preferences.
  ///
  /// Defaults to [_darkComputeLevel]%.
  static final StateNotifierProvider<SettingsEntry<int>, int>
      darkComputeLevelProvider = StateNotifierProvider<SettingsEntry<int>, int>(
    (StateNotifierProviderRef<SettingsEntry<int>, int> ref) {
      return SettingsEntry<int>(
        ref,
        defaultValue: _darkComputeLevel,
        key: _keyDarkComputeLevel,
      );
    },
    // Use the unique key-value DB key as provider name, useful for debugging.
    name: '${_keyDarkComputeLevel}Provider',
  );

  /// String key used for storing if dark mode uses true black.
  ///
  /// The associated provider uses same name with "Provider" added to it.
  static const String _keyDarkIsTrueBlack = 'darkIsTrueBlack';
}