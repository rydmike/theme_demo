import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/controllers/settings.dart';
import '../models/app_theme.dart';

/// The light [ThemeData] provider.
///
/// It is also just a simple StateProvider using our AppTheme.light method
/// and passing other StateProviders as property values to the method.
/// We can use this StateProvider in our MaterialApp as theme. Whenever any
/// of the StateProvider based property value are updated, the MaterialApp
/// will change theme and be rebuilt with new theme applied.
final Provider<ThemeData> lightThemeProvider = Provider<ThemeData>(
  (ProviderRef<ThemeData> ref) {
    return AppTheme.light(
      useMaterial3: ref.watch(Settings.useMaterial3Provider),
      usedTheme: ref.watch(Settings.schemeIndexProvider),
      surfaceMode: ref.watch(Settings.lightSurfaceModeProvider),
      blendLevel: ref.watch(Settings.lightBlendLevelProvider),
      swapColors: ref.watch(Settings.lightSwapColorsProvider),
      appBarElevation: ref.watch(Settings.appBarElevationProvider),
      appBarStyle: ref.watch(Settings.lightAppBarStyleProvider),
    );
  },
  name: 'lightThemeProvider',
);

/// The dark [ThemeData] provider.
///
/// Same setup as the [lightThemeProvider], we just have a few more properties.
final Provider<ThemeData> darkThemeProvider = Provider<ThemeData>(
  (ProviderRef<ThemeData> ref) {
    return AppTheme.dark(
      useMaterial3: ref.watch(Settings.useMaterial3Provider),
      usedTheme: ref.watch(Settings.schemeIndexProvider),
      surfaceMode: ref.watch(Settings.darkSurfaceModeProvider),
      blendLevel: ref.watch(Settings.darkBlendLevelProvider),
      swapColors: ref.watch(Settings.darkSwapColorsProvider),
      appBarElevation: ref.watch(Settings.appBarElevationProvider),
      appBarStyle: ref.watch(Settings.darkAppBarStyleProvider),
      darkIsTrueBlack: ref.watch(Settings.darkIsTrueBlackProvider),
      computeDark: ref.watch(Settings.darkComputeThemeProvider),
      darkLevel: ref.watch(Settings.darkLevelProvider),
    );
  },
  name: 'darkThemeProvider',
);
