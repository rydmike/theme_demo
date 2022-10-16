import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../persistence/key_value/key_value.dart';
import '../models/settings.dart';

// All settings providers.
//
// Riverpod Provider demo to manage application setting changes.

/// The index provider of the currently used color scheme and theme.
///
/// Defaults to first color scheme (0) in the list of used color schemes.
final StateNotifierProvider<Settings<int>, int> schemeProvider =
    StateNotifierProvider<Settings<int>, int>(
        (StateNotifierProviderRef<Settings<int>, int> ref) {
  return Settings<int>(
    ref,
    defaultValue: KeyValue.defaultSchemeIndex,
    key: KeyValue.keySchemeIndex,
  );
});

/// The primary colored light surface branding mode provider.
///
/// Defaults to FlexSurfaceMode.highSurfaceLowScaffold.
final StateNotifierProvider<Settings<FlexSurfaceMode>, FlexSurfaceMode>
    lightSurfaceModeProvider =
    StateNotifierProvider<Settings<FlexSurfaceMode>, FlexSurfaceMode>(
        (StateNotifierProviderRef<Settings<FlexSurfaceMode>, FlexSurfaceMode>
            ref) {
  return Settings<FlexSurfaceMode>(
    ref,
    defaultValue: KeyValue.defaultLightSurfaceMode,
    key: KeyValue.keyLightSurfaceMode,
  );
});

/// The primary colored dark surface branding mode provider.
///
/// Defaults to FlexSurfaceMode.highScaffoldLowSurface.
final StateNotifierProvider<Settings<FlexSurfaceMode>, FlexSurfaceMode>
    darkSurfaceModeProvider =
    StateNotifierProvider<Settings<FlexSurfaceMode>, FlexSurfaceMode>(
        (StateNotifierProviderRef<Settings<FlexSurfaceMode>, FlexSurfaceMode>
            ref) {
  return Settings<FlexSurfaceMode>(
    ref,
    defaultValue: KeyValue.defaultDarkSurfaceMode,
    key: KeyValue.keyDarkSurfaceMode,
  );
});

/// Provider for the strength of the blend level used by light surface mode.
///
/// Defaults to 10.
final StateNotifierProvider<Settings<int>, int> lightBlendLevelProvider =
    StateNotifierProvider<Settings<int>, int>(
        (StateNotifierProviderRef<Settings<int>, int> ref) {
  return Settings<int>(
    ref,
    defaultValue: KeyValue.defaultLightBlendLevel,
    key: KeyValue.keyLightBlendLevel,
  );
});

/// Provider for the strength of the blend level used by dark surface mode.
///
/// Defaults to 15.
final StateNotifierProvider<Settings<int>, int> darkBlendLevelProvider =
    StateNotifierProvider<Settings<int>, int>(
        (StateNotifierProviderRef<Settings<int>, int> ref) {
  return Settings<int>(
    ref,
    defaultValue: KeyValue.defaultDarkBlendLevel,
    key: KeyValue.keyDarkBlendLevel,
  );
});

/// The themed style of the light theme mode AppBar.
///
/// Defaults to primary color, the default for Material apps.
final StateNotifierProvider<Settings<FlexAppBarStyle>, FlexAppBarStyle>
    lightAppBarStyleProvider =
    StateNotifierProvider<Settings<FlexAppBarStyle>, FlexAppBarStyle>(
        (StateNotifierProviderRef<Settings<FlexAppBarStyle>, FlexAppBarStyle>
            ref) {
  return Settings<FlexAppBarStyle>(
    ref,
    defaultValue: KeyValue.defaultLightAppBarStyle,
    key: KeyValue.keyLightAppBarStyle,
  );
});

/// Provider for swapping primary and secondary colors in light theme mode.
///
/// Defaults to false.
final StateNotifierProvider<Settings<bool>, bool> lightSwapColorsProvider =
    StateNotifierProvider<Settings<bool>, bool>(
        (StateNotifierProviderRef<Settings<bool>, bool> ref) {
  return Settings<bool>(
    ref,
    defaultValue: KeyValue.defaultLightSwapColors,
    key: KeyValue.keyLightSwapColors,
  );
});

/// The themed style of the dark theme mode AppBar.
///
/// Defaults to background color. The default for Material apps is
/// [FlexAppBarStyle.material], which uses the Material background color
/// for active theme mode. The used default here [FlexAppBarStyle.background]
/// is the background color that gets primary color branding based on the
/// current [FlexSurfaceMode] setting.
final StateNotifierProvider<Settings<FlexAppBarStyle>, FlexAppBarStyle>
    darkAppBarStyleProvider =
    StateNotifierProvider<Settings<FlexAppBarStyle>, FlexAppBarStyle>(
        (StateNotifierProviderRef<Settings<FlexAppBarStyle>, FlexAppBarStyle>
            ref) {
  return Settings<FlexAppBarStyle>(
    ref,
    defaultValue: KeyValue.defaultDarkAppBarStyle,
    key: KeyValue.keyDarkAppBarStyle,
  );
});

/// Provider for swapping primary and secondary colors in dark theme mode.
///
/// Defaults to false.
final StateNotifierProvider<Settings<bool>, bool> darkSwapColorsProvider =
    StateNotifierProvider<Settings<bool>, bool>(
        (StateNotifierProviderRef<Settings<bool>, bool> ref) {
  return Settings<bool>(
    ref,
    defaultValue: KeyValue.defaultDarkSwapColors,
    key: KeyValue.keyDarkSwapColors,
  );
});

/// Provider for the elevation level used on the AppBar theme.
///
/// Defaults to 0.
final StateNotifierProvider<Settings<double>, double> appBarElevationProvider =
    StateNotifierProvider<Settings<double>, double>(
        (StateNotifierProviderRef<Settings<double>, double> ref) {
  return Settings<double>(
    ref,
    defaultValue: KeyValue.defaultAppBarElevation,
    key: KeyValue.keyAppBarElevation,
  );
});

/// Option to use dark scheme calculation from light scheme colors, instead
/// of using the pre-defined dark scheme colors.
///
/// This can be used use fi you want to try to find colors based on you light
/// scheme colors, then use this mode and adjust the saturation level, when you
/// find colors that work well visually you can pick them with a picker and
/// change you defined dark colors to those picked color values instead.
///
/// Handy for making a tuned dark scheme based on light scheme colors. You
/// can also use the principle shown here as a way to make just computed dark
/// themes from light scheme color definitions, just pick a saturation level
/// that you think work well enough and use that as the dark scheme color input
/// instead. There is an example of this in the FlexColorScheme package
/// tutorial as well.
final StateNotifierProvider<Settings<bool>, bool> computeDarkThemeProvider =
    StateNotifierProvider<Settings<bool>, bool>(
        (StateNotifierProviderRef<Settings<bool>, bool> ref) {
  return Settings<bool>(
    ref,
    defaultValue: KeyValue.defaultComputeDarkTheme,
    key: KeyValue.keyComputeDarkTheme,
  );
});

/// Dark scheme brightness level provider, used for adjusting the color
/// saturation of the dark color scheme calculated from light scheme.
///
/// Value 0% results in same colors as light theme color scheme, value 100%
/// results in no colors, a black and white grey scale theme. Values between
/// 15%...40% usually produce decent looking dark color scheme from the used
/// light scheme colors. What works best depends on how saturated the light
/// scheme colors are, and personal preferences.
///
/// Defaults to 35%.
final StateNotifierProvider<Settings<int>, int> darkLevelProvider =
    StateNotifierProvider<Settings<int>, int>(
        (StateNotifierProviderRef<Settings<int>, int> ref) {
  return Settings<int>(
    ref,
    defaultValue: KeyValue.defaultDarkLevel,
    key: KeyValue.keyDarkLevel,
  );
});

/// Provider for using true black, instead of normal dark, for dark theme mode.
///
/// Defaults to false.
final StateNotifierProvider<Settings<bool>, bool> darkIsTrueBlackProvider =
    StateNotifierProvider<Settings<bool>, bool>(
        (StateNotifierProviderRef<Settings<bool>, bool> ref) {
  return Settings<bool>(
    ref,
    defaultValue: KeyValue.defaultDarkIsTrueBlack,
    key: KeyValue.keyDarkIsTrueBlack,
  );
});
