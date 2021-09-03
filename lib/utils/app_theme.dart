import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:theme_demo/utils/app_const.dart';
import 'package:theme_demo/utils/app_insets.dart';

/// The theme for this app are defined here.
class AppTheme {
  // This constructor prevents external instantiation and extension.
  AppTheme._();

  /// Returns the light theme based on properties passed to it.
  static ThemeData light({
    required int usedTheme,
    required bool swapColors,
    required FlexAppBarStyle appBarStyle,
    required double appBarElevation,
    required FlexSurface surfaceStyle,
  }) {
    // We need to use the ColorScheme defined by used FlexColorScheme as input
    // to other theme's, so we create it first.
    final FlexColorScheme _flexScheme = FlexColorScheme.light(
      colors: schemes[usedTheme].light,
      swapColors: swapColors,
      appBarStyle: appBarStyle,
      surfaceStyle: surfaceStyle,
      appBarElevation: appBarElevation,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      fontFamily: AppFonts.mainFont,
    );
    // Currently we just use ColorScheme in one sub-theme, but if needed in
    // other sub-themes too, then here it is.
    final ColorScheme _colorScheme = _flexScheme.toScheme;
    return _flexScheme.toTheme.copyWith(
      // Add our custom button shape and padding theming.
      elevatedButtonTheme: elevatedButtonTheme,
      outlinedButtonTheme: outlinedButtonTheme(
        _colorScheme,
        const Color(0x1F000000),
      ),
      textButtonTheme: textButtonTheme,
      toggleButtonsTheme: toggleButtonsTheme(_colorScheme),
    );
  }

  /// Returns the dark theme based on properties passed to it.
  static ThemeData dark({
    required int usedTheme,
    required bool swapColors,
    required FlexAppBarStyle appBarStyle,
    required double appBarElevation,
    required FlexSurface surfaceStyle,
    required bool darkIsTrueBlack,
    required bool computeDark,
    required int darkLevel,
  }) {
    // We need to use the ColorScheme defined by used FlexColorScheme as input
    // to sub-theme's, so we create it first.
    final FlexColorScheme _flexScheme = FlexColorScheme.dark(
      colors: computeDark
          ? schemes[usedTheme].light.defaultError.toDark(darkLevel)
          : schemes[usedTheme].dark,
      swapColors: swapColors,
      appBarStyle: appBarStyle,
      surfaceStyle: surfaceStyle,
      appBarElevation: appBarElevation,
      darkIsTrueBlack: darkIsTrueBlack,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      fontFamily: AppFonts.mainFont,
    );
    // Currently we just use ColorScheme in one sub-theme, but if needed in
    // other sub-themes too, then here it is.
    final ColorScheme _colorScheme = _flexScheme.toScheme;
    // Convert FlexColorScheme to ThemeData, apply sub-themes and return it.
    return _flexScheme.toTheme.copyWith(
      // Add our custom button shape and padding theming.
      elevatedButtonTheme: elevatedButtonTheme,
      outlinedButtonTheme: outlinedButtonTheme(
        _colorScheme,
        const Color(0x1FFFFFFF),
      ),
      textButtonTheme: textButtonTheme,
      toggleButtonsTheme: toggleButtonsTheme(_colorScheme),
    );
  }

  // These theme definitions are used to give all Material buttons a
  // a Stadium rounded design. This is just to demonstrate more involved
  // sub-theming with FlexColorScheme.
  static ElevatedButtonThemeData get elevatedButtonTheme =>
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        minimumSize: minButtonSize,
        shape: const StadiumBorder(), //buttonShape,
        padding: roundButtonPadding,
        elevation: 0,
      ));

  static OutlinedButtonThemeData outlinedButtonTheme(
          ColorScheme scheme, Color disabledColor) =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: minButtonSize,
          shape: const StadiumBorder(),
          padding: roundButtonPadding,
        ).copyWith(
          side: MaterialStateProperty.resolveWith<BorderSide?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return BorderSide(
                  color: disabledColor,
                  width: 0.5,
                );
              }
              if (states.contains(MaterialState.error)) {
                return BorderSide(
                  color: scheme.error,
                  width: AppInsets.outlineThickness,
                );
              }
              return BorderSide(
                color: scheme.primary,
                width: AppInsets.outlineThickness,
              );
            },
          ),
        ),
      );

  static TextButtonThemeData get textButtonTheme => TextButtonThemeData(
          style: TextButton.styleFrom(
        minimumSize: minButtonSize,
        shape: const StadiumBorder(),
        padding: roundButtonPadding,
      ));

  // The stadium rounded buttons generally need a bit more padding to look good,
  // adjust here to tune the padding for all of them globally in the app.
  static const EdgeInsets roundButtonPadding = EdgeInsets.symmetric(
    horizontal: AppInsets.l,
    vertical: AppInsets.s,
  );

  // The old buttons had a minimum size that looked OK, we keep that.
  static const Size minButtonSize = Size(88, 36);

  /// ToggleButtons theme
  static ToggleButtonsThemeData toggleButtonsTheme(ColorScheme colorScheme) =>
      ToggleButtonsThemeData(
        selectedColor: colorScheme.onPrimary,
        color: colorScheme.primary.withOpacity(0.85),
        fillColor: colorScheme.primary.withOpacity(0.85),
        hoverColor: colorScheme.primary.withOpacity(0.2),
        focusColor: colorScheme.primary.withOpacity(0.3),
        borderWidth: AppInsets.outlineThickness,
        borderColor: colorScheme.primary,
        selectedBorderColor: colorScheme.primary,
        borderRadius: BorderRadius.circular(AppInsets.cornerRadius),
      );

  // We could also use the FlexSchemeColor.from() constructor and define less
  // color properties and get some of them computed by the from factory.
  // If we do that then custom colors cannot be const, but otherwise it
  // works the same. In this demo we specify all required colors and do not
  // use the convenience features offered by the FlexSchemeColor.from() factory.

  // Custom dark red and green scheme.
  static const FlexSchemeColor _customScheme1Light = FlexSchemeColor(
    primary: Color(0xFF4E0028),
    primaryVariant: Color(0xFF320019),
    secondary: Color(0xFF003419),
    secondaryVariant: Color(0xFF002411),
    appBarColor: Color(0xFF002411),
  );
  static const FlexSchemeColor _customScheme1Dark = FlexSchemeColor(
    primary: Color(0xFF9E7389),
    primaryVariant: Color(0xFF775C69),
    secondary: Color(0xFF738F81),
    secondaryVariant: Color(0xFF5C7267),
    appBarColor: Color(0xFF5C7267),
  );
  // San Juan blue and sea pink.
  static const FlexSchemeColor _customScheme2Light = FlexSchemeColor(
    primary: Color(0xFF395778),
    primaryVariant: Color(0xFF637E9F),
    secondary: Color(0xFFE7949A),
    secondaryVariant: Color(0xFFF2C4C7),
    appBarColor: Color(0xFFF2C4C7),
  );
  static const FlexSchemeColor _customScheme2Dark = FlexSchemeColor(
    primary: Color(0xFF5E7691),
    primaryVariant: Color(0xFF8096B1),
    secondary: Color(0xFFEBA8AD),
    secondaryVariant: Color(0xFFF4CFD1),
    appBarColor: Color(0xFFF4CFD1),
  );
  // Custom dark green and mustard yellow scheme
  static const FlexSchemeColor _customScheme3Light = FlexSchemeColor(
    primary: Color(0xFF2A3639),
    primaryVariant: Color(0xFF98B694),
    secondary: Color(0xFFC1AA44),
    secondaryVariant: Color(0xFFAF942B),
    appBarColor: Color(0xFFAF942B),
  );
  static const FlexSchemeColor _customScheme3Dark = FlexSchemeColor(
    primary: Color(0xFF76887B),
    primaryVariant: Color(0xFFB6CBB3),
    secondary: Color(0xFFD3C37B),
    secondaryVariant: Color(0xFFC6B36A),
    appBarColor: Color(0xFFC6B36A),
  );
  // Oregon orange and green theme
  static const FlexSchemeColor _customScheme4Light = FlexSchemeColor(
    primary: Color(0xFF993200),
    primaryVariant: Color(0xFF6E2400),
    secondary: Color(0xFF1B5C62),
    secondaryVariant: Color(0xFF134045),
    appBarColor: Color(0xFF134045),
  );
  static const FlexSchemeColor _customScheme4Dark = FlexSchemeColor(
    primary: Color(0xFFAE6846),
    primaryVariant: Color(0xFFBE866B),
    secondary: Color(0xFF5FA4AC),
    secondaryVariant: Color(0xFF4C838A),
    appBarColor: Color(0xFF4C838A),
  );
  // Tapestry pink and laser yellow.
  static const FlexSchemeColor _customScheme5Light = FlexSchemeColor(
    primary: Color(0xFFAA637F),
    primaryVariant: Color(0xFF8D4D66),
    secondary: Color(0xFFC2A86B),
    secondaryVariant: Color(0xFFB19249),
    appBarColor: Color(0xFFB19249),
  );
  static const FlexSchemeColor _customScheme5Dark = FlexSchemeColor(
    primary: Color(0xFFBC859B),
    primaryVariant: Color(0xFFA67487),
    secondary: Color(0xFFCFBB8B),
    secondaryVariant: Color(0xFFC2A970),
    appBarColor: Color(0xFFC2A970),
  );

  // Create a list with all our custom color schemes and add
  // all the FlexColorScheme built-in ones to the end of the list.
  static List<FlexSchemeData> schemes = <FlexSchemeData>[
    // Add all our custom schemes to the list of schemes.
    const FlexSchemeData(
      name: 'Purple amd Green (default)',
      description: 'Deep purple and sombre green.',
      light: _customScheme1Light,
      dark: _customScheme1Dark,
    ),
    const FlexSchemeData(
      name: 'Juan and pink',
      description: 'San Juan blue and sea pink.',
      light: _customScheme2Light,
      dark: _customScheme2Dark,
    ),
    const FlexSchemeData(
      name: 'Moss and mustard',
      description: 'Moss green and mustard yellow.',
      light: _customScheme3Light,
      dark: _customScheme3Dark,
    ),
    const FlexSchemeData(
      name: 'Oregon and Eden',
      description: 'Oregon orange and eden green.',
      light: _customScheme4Light,
      dark: _customScheme4Dark,
    ),
    const FlexSchemeData(
      name: 'Pink and laser',
      description: 'Tapestry pink and laser yellow',
      light: _customScheme5Light,
      dark: _customScheme5Dark,
    ),
    // After custom color schemes, add all built in FlexColor schemes.
    // TODO(rydmike): Make list const in the package, then it can all be const.
    ...FlexColor.schemesList,
  ];
}
