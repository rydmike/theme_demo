import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../persistence/key_value/key_value.dart';
import '../../settings/models/settings.dart';
import '../../settings/providers/settings_providers.dart';
import '../models/app_theme.dart';

/// The themeModeProvider represents a [StateProvider] to provide the state of
/// the [ThemeMode], so to be able to toggle the application wide theme mode.
final StateNotifierProvider<Settings<ThemeMode>, ThemeMode> themeModeProvider =
    StateNotifierProvider<Settings<ThemeMode>, ThemeMode>(
        (StateNotifierProviderRef<Settings<ThemeMode>, ThemeMode> ref) {
  return Settings<ThemeMode>(
    ref,
    defaultValue: KeyValue.defaultThemeMode,
    key: KeyValue.keyThemeMode,
  );
});

/// The light [ThemeData] provider.
///
/// It is also just a simple StateProvider using our AppTheme.light method
/// and passing other StateProviders as property values to the method.
/// We can use this StateProvider in our MaterialApp as theme. Whenever any
/// of the StateProvider based property value are updated, the MaterialApp
/// will change theme and be rebuilt with new theme applied.
final Provider<ThemeData> lightThemeProvider =
    Provider<ThemeData>((ProviderRef<ThemeData> ref) {
  return AppTheme.light(
    usedTheme: ref.watch(schemeProvider),
    swapColors: ref.watch(lightSwapColorsProvider),
    appBarStyle: ref.watch(lightAppBarStyleProvider),
    appBarElevation: ref.watch(appBarElevationProvider),
    surfaceMode: ref.watch(lightSurfaceModeProvider),
    blendLevel: ref.watch(lightBlendLevelProvider),
  );
});

/// The dark [ThemeData] provider.
///
/// Same setup as the [lightThemeProvider], we just have a few more properties.
final Provider<ThemeData> darkThemeProvider =
    Provider<ThemeData>((ProviderRef<ThemeData> ref) {
  return AppTheme.dark(
    usedTheme: ref.watch(schemeProvider),
    swapColors: ref.watch(darkSwapColorsProvider),
    appBarStyle: ref.watch(darkAppBarStyleProvider),
    appBarElevation: ref.watch(appBarElevationProvider),
    surfaceMode: ref.watch(darkSurfaceModeProvider),
    blendLevel: ref.watch(darkBlendLevelProvider),
    darkIsTrueBlack: ref.watch(darkIsTrueBlackProvider),
    computeDark: ref.watch(computeDarkThemeProvider),
    darkLevel: ref.watch(darkLevelProvider),
  );
});
