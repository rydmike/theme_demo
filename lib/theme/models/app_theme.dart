import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_fonts.dart';
import 'flex_tone.dart';

/// The theme for this app are defined here.
class AppTheme {
  // This constructor prevents external instantiation and extension.
  AppTheme._();

  /// Returns the light theme based on properties passed to it.
  static ThemeData light({
    required bool useMaterial3,
    required int usedTheme,
    required bool swapColors,
    required bool usePrimaryKeyColor,
    required bool useSecondaryKeyColor,
    required bool useTertiaryKeyColor,
    required int usedFlexTone,
    required FlexSurfaceMode surfaceMode,
    required int blendLevel,
    required double appBarElevation,
    required FlexAppBarStyle? appBarStyle,
    required double appBarOpacity,
    required bool transparentStatusBar,
    required TargetPlatform platform,
  }) {
    // We need to use the ColorScheme defined by used FlexColorScheme as input
    // to other theme's, so we create it first.
    final FlexColorScheme flexScheme = FlexColorScheme.light(
      colors: schemes[usedTheme].light,
      swapColors: swapColors,
      surfaceMode: surfaceMode,
      blendLevel: blendLevel,
      appBarElevation: appBarElevation,
      appBarStyle: appBarStyle,
      appBarOpacity: appBarOpacity,
      transparentStatusBar: transparentStatusBar,
      subThemesData: const FlexSubThemesData(
        thinBorderWidth: 1,
        thickBorderWidth: 2,
      ),
      keyColors: FlexKeyColors(
        useKeyColors: usePrimaryKeyColor,
        useSecondary: useSecondaryKeyColor,
        useTertiary: useTertiaryKeyColor,
      ),
      tones: FlexTone.values[usedFlexTone].tones(Brightness.light),
      //
      useMaterial3: useMaterial3,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      fontFamily: AppFonts.mainFont,
      typography: Typography.material2021(platform: platform),
      platform: platform,
    );
    // Convert FlexColorScheme to ThemeData.
    return flexScheme.toTheme;
  }

  /// Returns the dark theme based on properties passed to it.
  static ThemeData dark({
    required bool useMaterial3,
    required int usedTheme,
    required bool swapColors,
    required bool usePrimaryKeyColor,
    required bool useSecondaryKeyColor,
    required bool useTertiaryKeyColor,
    required int usedFlexTone,
    required FlexSurfaceMode surfaceMode,
    required int blendLevel,
    required double appBarElevation,
    required FlexAppBarStyle? appBarStyle,
    required double appBarOpacity,
    required bool transparentStatusBar,
    required bool computeDark,
    required int darkLevel,
    required bool darkIsTrueBlack,
    required TargetPlatform platform,
  }) {
    // We need to use the ColorScheme defined by used FlexColorScheme as input
    // to sub-theme's, so we create it first.
    final FlexColorScheme flexScheme = FlexColorScheme.dark(
      colors: computeDark
          ? schemes[usedTheme].light.defaultError.toDark(darkLevel)
          : schemes[usedTheme].dark,
      swapColors: swapColors,
      surfaceMode: surfaceMode,
      blendLevel: blendLevel,
      appBarElevation: appBarElevation,
      appBarStyle: appBarStyle,
      appBarOpacity: appBarOpacity,
      transparentStatusBar: transparentStatusBar,
      darkIsTrueBlack: darkIsTrueBlack,
      subThemesData: const FlexSubThemesData(
        thinBorderWidth: 1,
        thickBorderWidth: 2,
      ),
      keyColors: FlexKeyColors(
        useKeyColors: usePrimaryKeyColor,
        useSecondary: useSecondaryKeyColor,
        useTertiary: useTertiaryKeyColor,
      ),
      tones: FlexTone.values[usedFlexTone].tones(Brightness.dark),
      //
      useMaterial3: useMaterial3,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      fontFamily: AppFonts.mainFont,
      typography: Typography.material2021(platform: platform),
      platform: platform,
    );
    // Convert FlexColorScheme to ThemeData.
    return flexScheme.toTheme;
  }

  // We could also use the FlexSchemeColor.from() constructor and define less
  // color properties and get some of them computed by the from factory.
  // If we do that then custom colors cannot be const, but otherwise it
  // works the same. In this demo we specify all required colors and do not
  // use the convenience features offered by the FlexSchemeColor.from() factory.

  // San Juan blue and sea pink.
  static const FlexSchemeColor _customScheme2Light = FlexSchemeColor(
    primary: Color(0xFF395778),
    primaryContainer: Color(0xFF8096B1),
    secondary: Color(0xFFE7949A),
    secondaryContainer: Color(0xFFF2C4C7),
    tertiary: Color(0xFF49709B),
    tertiaryContainer: Color(0xFF7995B3),
    appBarColor: Color(0xFFE7949A),
  );
  static const FlexSchemeColor _customScheme2Dark = FlexSchemeColor(
    primary: Color(0xFF8096B1),
    primaryContainer: Color(0xFF395778),
    secondary: Color(0xFFF2C4C7),
    secondaryContainer: Color(0xFFE7949A),
    tertiary: Color(0xFFA0B0C4),
    tertiaryContainer: Color(0xFFC9D5E3),
    appBarColor: Color(0xFFF2C4C7),
  );
  // Custom dark green and mustard yellow scheme
  static const FlexSchemeColor _customScheme3Light = FlexSchemeColor(
    primary: Color(0xFF2A3639),
    primaryContainer: Color(0xFF98B694),
    secondary: Color(0xFFC1AA44),
    secondaryContainer: Color(0xFFD3C37B),
    tertiary: Color(0xFF405256),
    tertiaryContainer: Color(0xFF64767A),
    appBarColor: Color(0xFFC1AA44),
  );
  static const FlexSchemeColor _customScheme3Dark = FlexSchemeColor(
    primary: Color(0xFF98B694),
    primaryContainer: Color(0xFF2A3639),
    secondary: Color(0xFFD3C37B),
    secondaryContainer: Color(0xFFC1AA44),
    tertiary: Color(0xFFB5CBB2),
    tertiaryContainer: Color(0xFFDDEADB),
    appBarColor: Color(0xFFC6B36A),
  );
  // Oregon orange and green theme
  static const FlexSchemeColor _customScheme4Light = FlexSchemeColor(
    primary: Color(0xFF993200),
    primaryContainer: Color(0xFFBE866B),
    secondary: Color(0xFF1B5C62),
    secondaryContainer: Color(0xFF5FA4AC),
    tertiary: Color(0xFFCC4300),
    tertiaryContainer: Color(0xFFE16C33),
    appBarColor: Color(0xFF1B5C62),
  );
  static const FlexSchemeColor _customScheme4Dark = FlexSchemeColor(
    primary: Color(0xFFBE866B),
    primaryContainer: Color(0xFF993200),
    secondary: Color(0xFF5FA4AC),
    secondaryContainer: Color(0xFF1B5C62),
    tertiary: Color(0xFFCEA38E),
    tertiaryContainer: Color(0xFFE9CABB),
    appBarColor: Color(0xFF5FA4AC),
  );
  // Tapestry pink and laser yellow.
  static const FlexSchemeColor _customScheme5Light = FlexSchemeColor(
    primary: Color(0xFFAA637F),
    // As an example, say we like one of the existing built in color definitions
    // for the container color then just re-use it there:
    primaryContainer: FlexColor.sakuraLightPrimaryContainer,
    secondary: Color(0xFFB19249),
    secondaryContainer: Color(0xFFCFBB8B),
    tertiary: Color(0xFFBC849A),
    tertiaryContainer: Color(0xFFDAAEC0),
    appBarColor: Color(0xFFB19249),
  );
  static const FlexSchemeColor _customScheme5Dark = FlexSchemeColor(
    primary: Color(0xFFBC859B),
    // We use the corresponding pre-defined dark variant color.
    primaryContainer: FlexColor.sakuraDarkPrimaryContainer,
    secondary: Color(0xFFCFBB8B),
    secondaryContainer: Color(0xFFB19249),
    tertiary: Color(0xFFCEA6B6),
    tertiaryContainer: Color(0xFFEBD1DC),
    appBarColor: Color(0xFFCFBB8B),
  );

  // Create a list with all our custom color schemes and add
  // all the FlexColorScheme built-in ones to the end of the list.
  static const List<FlexSchemeData> schemes = <FlexSchemeData>[
    // Add all our custom schemes to the list of schemes.
    FlexSchemeData(
      name: 'Juan and pink',
      description: 'San Juan blue and sea pink.',
      light: _customScheme2Light,
      dark: _customScheme2Dark,
    ),
    // As an example, say you want to add one of the pre-defined FlexColor
    // schemes to the list of schemes we offer as user choices, then just pick
    // the ones you want and insert in the order you want it, here we
    // add Mandy Red.
    FlexColor.mandyRed,
    // And continue with your own custom schemes, with own custom names.
    FlexSchemeData(
      name: 'Moss and mustard',
      description: 'Moss green and mustard yellow.',
      light: _customScheme3Light,
      dark: _customScheme3Dark,
    ),
    FlexSchemeData(
      name: 'Oregon and Eden',
      description: 'Oregon orange and eden green.',
      light: _customScheme4Light,
      dark: _customScheme4Dark,
    ),
    FlexSchemeData(
      name: 'Pink and laser',
      description: 'Tapestry pink and laser yellow',
      light: _customScheme5Light,
      dark: _customScheme5Dark,
    ),
    //
    // As an example:
    // After all our custom color schemes, and hand picked built-in colors
    // we add all built in FlexColor schemes.
    // The MandyRed scheme will of course show up as a duplicate when we do
    // this, since we already added it manually already. This is just to
    // demonstrating how to easily add all existing scheme to end of our custom
    // scheme choices.
    ...FlexColor.schemesList,
  ];
}
