import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home/controllers/platform_provider.dart';
import '../../settings/controllers/settings.dart';
import '../models/app_theme.dart';
import '../models/flex_tone.dart';

/// The light [ThemeData] provider.
///
/// It is also just a simple StateProvider using our AppTheme.light method
/// and passing other StateProviders as property values to the method.
/// We can use this StateProvider in our MaterialApp as theme. Whenever any
/// of the StateProvider based property value are updated, the MaterialApp
/// will change theme and be rebuilt with new theme applied.
final Provider<ThemeData> lightThemeProvider = Provider<ThemeData>(
  (ProviderRef<ThemeData> ref) {
    // Make a safe FlexTones config getter from our unsafe int.
    final bool useSeed = ref.watch(Settings.usePrimaryKeyColorProvider);
    final int flexTone = ref.watch(Settings.usedFlexToneProvider);
    final int usedFlexTone =
        flexTone < 0 || flexTone >= FlexTone.values.length || !useSeed
            ? 0
            : flexTone;

    return AppTheme.light(
      useMaterial3: ref.watch(Settings.useMaterial3Provider),
      usedTheme: ref.watch(Settings.schemeIndexProvider),
      swapColors: ref.watch(Settings.lightSwapColorsProvider),
      usePrimaryKeyColor: useSeed,
      useSecondaryKeyColor: ref.watch(Settings.useSecondaryKeyColorProvider),
      useTertiaryKeyColor: ref.watch(Settings.useTertiaryKeyColorProvider),
      usedFlexTone: usedFlexTone,
      surfaceMode: ref.watch(Settings.lightSurfaceModeProvider),
      blendLevel: ref.watch(Settings.lightBlendLevelProvider),
      appBarElevation: ref.watch(Settings.appBarElevationProvider),
      appBarStyle: ref.watch(Settings.lightAppBarStyleProvider),
      appBarOpacity: ref.watch(Settings.lightAppBarOpacityProvider),
      transparentStatusBar: ref.watch(Settings.transparentStatusBarProvider),
      useSubTheme: ref.watch(Settings.useSubThemesProvider),
      defaultRadius: ref.watch(Settings.defaultRadiusProvider),
      platform: ref.watch(platformProvider),
    );
  },
  name: 'lightThemeProvider',
);

/// The dark [ThemeData] provider.
///
/// Same setup as the [lightThemeProvider], we just have a few more properties.
final Provider<ThemeData> darkThemeProvider = Provider<ThemeData>(
  (ProviderRef<ThemeData> ref) {
    // Make a safe FlexTones config getter from our unsafe int.
    final bool useSeed = ref.watch(Settings.usePrimaryKeyColorProvider);
    final int flexTone = ref.watch(Settings.usedFlexToneProvider);
    final int usedFlexTone =
        flexTone < 0 || flexTone >= FlexTone.values.length || !useSeed
            ? 0
            : flexTone;

    return AppTheme.dark(
      useMaterial3: ref.watch(Settings.useMaterial3Provider),
      usedTheme: ref.watch(Settings.schemeIndexProvider),
      swapColors: ref.watch(Settings.darkSwapColorsProvider),
      usePrimaryKeyColor: useSeed,
      useSecondaryKeyColor: ref.watch(Settings.useSecondaryKeyColorProvider),
      useTertiaryKeyColor: ref.watch(Settings.useTertiaryKeyColorProvider),
      usedFlexTone: usedFlexTone,
      surfaceMode: ref.watch(Settings.darkSurfaceModeProvider),
      blendLevel: ref.watch(Settings.darkBlendLevelProvider),
      appBarElevation: ref.watch(Settings.appBarElevationProvider),
      appBarStyle: ref.watch(Settings.darkAppBarStyleProvider),
      appBarOpacity: ref.watch(Settings.darkAppBarOpacityProvider),
      transparentStatusBar: ref.watch(Settings.transparentStatusBarProvider),
      darkIsTrueBlack: ref.watch(Settings.darkIsTrueBlackProvider),
      computeDark: ref.watch(Settings.darkComputeThemeProvider),
      darkLevel: ref.watch(Settings.darkComputeLevelProvider),
      useSubTheme: ref.watch(Settings.useSubThemesProvider),
      defaultRadius: ref.watch(Settings.defaultRadiusProvider),
      platform: ref.watch(platformProvider),
    );
  },
  name: 'darkThemeProvider',
);
