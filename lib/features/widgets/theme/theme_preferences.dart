import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/universal/animated_hide.dart';
import '../../../utils/app_insets.dart';
import 'app_bar_elevation_slider.dart';
import 'compute_dark_theme_switch.dart';
import 'dark_app_bar_style_switch.dart';
import 'dark_colors_swap_switch.dart';
import 'dark_level_slider.dart';
import 'light_app_bar_style_switch.dart';
import 'light_colors_swap_switch.dart';
import 'surface_style_switch.dart';
import 'theme_mode_switch.dart';
import 'theme_selector.dart';
import 'true_black_switch.dart';

/// A widget that allows us to change a large number of theme preferences.
///
/// In this example we are using this in a BottomSheet, just as an example.
/// The Widgets we use to control the use Riverpod StateProviders and change
/// those state properties. Those properties are then used in the the theme
/// definitions that we use in out MaterialApp. As the state properties are
/// modified in the UI, the theme changes and the app rebuilds with the new
/// selected theme applied.
///
/// The Flutter theme handles the animation between theme changes since its
/// properties lerp between values and use animated theme.
class ThemePreferences extends ConsumerWidget {
  const ThemePreferences({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    return SizedBox(
      height: 400,
      child: Column(
        children: <Widget>[
          const _CloseBottomSheetHandle(),
          Expanded(
            child: ListView(
              children: <Widget>[
                const Divider(),
                const ThemeSelector(),
                const ListTile(
                  title: Text('Theme mode'),
                  trailing: ThemeModeSwitch(),
                ),
                if (isLight)
                  const LightColorsSwapSwitch()
                else
                  const DarkColorsSwapSwitch(),
                // Hide the extra dark mode controls in light theme.
                AnimatedHide(
                  hide: isLight,
                  child: Column(
                    children: const <Widget>[
                      TrueBlackSwitch(),
                      ComputeDarkThemeSwitch(),
                      DarkLevelSlider(),
                    ],
                  ),
                ),
                const Divider(),
                const ListTile(title: Text('Surface branding')),
                const ListTile(trailing: SurfaceStyleSwitch()),
                const Divider(),
                const ListTile(title: Text('AppBar style')),
                ListTile(
                  trailing: isLight
                      ? const LightAppBarStyleSwitch()
                      : const DarkAppBarStyleSwitch(),
                ),
                const AppBarElevationSlider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// This widget is used to draw a bottom sheet handle that can be tapped
// to close the bottom sheet. Usually placed as top item in a column or
// ListView in a BottomSheet.
class _CloseBottomSheetHandle extends StatelessWidget {
  const _CloseBottomSheetHandle();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: SizedBox(
        height: AppInsets.xl,
        child: Center(
          child: Material(
            color: Theme.of(context).colorScheme.primary.withAlpha(150),
            type: MaterialType.card,
            elevation: 1,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppInsets.xl),
            ),
            child: const SizedBox(width: 100, height: 8),
          ),
        ),
      ),
    );
  }
}
