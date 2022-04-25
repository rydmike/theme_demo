import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/app_theme.dart';

// Riverpod Provider demo to manage application theme changes.
//
// You can put simple providers in same, just one provider per file or
// group them in same files, and put the files where they make sense to you.
//
//

/// We use a simple StateProvider to toggle application ThemeMode.
final StateProvider<ThemeMode> themeModeProvider =
    StateProvider<ThemeMode>((StateProviderRef<ThemeMode> ref) {
  return ThemeMode.system;
});

/// The light [ThemeData] provider.
///
/// It is also just a simple StateProvider using our AppTheme.light method
/// and passing other StateProviders as property values to the method.
/// We can use this StateProvider in our MaterialApp as theme. Whenever any
/// of the StateProvider based property value are updated, the MaterialApp
/// will change theme and be rebuilt with new theme applied.
final StateProvider<ThemeData> lightThemeProvider =
    StateProvider<ThemeData>((StateProviderRef<ThemeData> ref) {
  return AppTheme.light(
    usedTheme: ref.watch(schemeProvider),
    swapColors: ref.watch(lightSwapColorsProvider),
    appBarStyle: ref.watch(lightAppBarStyleProvider),
    appBarElevation: ref.watch(appBarElevationProvider),
    surfaceStyle: ref.watch(surfaceStyleProvider),
  );
});

/// The dark [ThemeData] provider.
///
/// Same setup as the [lightThemeProvider], we just have a few more properties.
final StateProvider<ThemeData> darkThemeProvider =
    StateProvider<ThemeData>((StateProviderRef<ThemeData> ref) {
  return AppTheme.dark(
    usedTheme: ref.watch(schemeProvider),
    swapColors: ref.watch(darkSwapColorsProvider),
    appBarStyle: ref.watch(darkAppBarStyleProvider),
    appBarElevation: ref.watch(appBarElevationProvider),
    surfaceStyle: ref.watch(surfaceStyleProvider),
    darkIsTrueBlack: ref.watch(darkIsTrueBlackProvider),
    computeDark: ref.watch(computeDarkThemeProvider),
    darkLevel: ref.watch(darkLevelProvider),
  );
});

/// The index provider of the currently used color scheme and theme.
///
/// Defaults to first color scheme (0) in the list of used color schemes.
final StateProvider<int> schemeProvider =
    StateProvider<int>((StateProviderRef<int> ref) {
  return 0;
});

/// The primary colored surface branding style provider.
///
/// Defaults to medium strength.
final StateProvider<FlexSurface> surfaceStyleProvider =
    StateProvider<FlexSurface>((StateProviderRef<FlexSurface> ref) {
  return FlexSurface.medium;
});

/// The themed style of the light theme mode AppBar.
///
/// Defaults to primary color, the default for Material apps.
final StateProvider<FlexAppBarStyle> lightAppBarStyleProvider =
    StateProvider<FlexAppBarStyle>((StateProviderRef<FlexAppBarStyle> ref) {
  return FlexAppBarStyle.primary;
});

/// Provider for swapping primary and secondary colors in light theme mode.
final StateProvider<bool> lightSwapColorsProvider =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return false;
});

/// The themed style of the dark theme mode AppBar.
///
/// Defaults to background color. The default for Material apps is
/// [FlexAppBarStyle.material], which uses the Material background color
/// for active theme mode. The used default here [FlexAppBarStyle.background]
/// is the background color that gets primary color branding based on the
/// current [FlexSurface] setting. If [FlexSurface.material] is used, then this
/// will when [FlexAppBarStyle.background] is used actually result in same color
/// as when using [FlexAppBarStyle.material].
final StateProvider<FlexAppBarStyle> darkAppBarStyleProvider =
    StateProvider<FlexAppBarStyle>((StateProviderRef<FlexAppBarStyle> ref) {
  return FlexAppBarStyle.background;
});

/// Provider for swapping primary and secondary colors in dark theme mode.
final StateProvider<bool> darkSwapColorsProvider =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return false;
});

/// Provider for the elevation level used on the AppBar theme.
final StateProvider<double> appBarElevationProvider =
    StateProvider<double>((StateProviderRef<double> ref) {
  return 0.5;
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
final StateProvider<bool> computeDarkThemeProvider =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return false;
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
final StateProvider<int> darkLevelProvider =
    StateProvider<int>((StateProviderRef<int> ref) {
  return 35;
});

// Provider for using true black, instead of normal dark, for dark theme mode.
final StateProvider<bool> darkIsTrueBlackProvider =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return false;
});
