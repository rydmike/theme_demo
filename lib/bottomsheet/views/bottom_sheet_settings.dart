import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_insets.dart';
import '../../../settings/views/widgets/app_bar_elevation_slider.dart';
import '../../../settings/views/widgets/dark_app_bar_style_toggle_buttons.dart';
import '../../../settings/views/widgets/dark_colors_swap_switch.dart';
import '../../../settings/views/widgets/dark_compute_theme_switch.dart';
import '../../../settings/views/widgets/dark_level_slider.dart';
import '../../../settings/views/widgets/dark_true_black_switch.dart';
import '../../../settings/views/widgets/light_app_bar_style_toggle_buttons.dart';
import '../../../settings/views/widgets/light_colors_swap_switch.dart';
import '../../../settings/views/widgets/theme_mode_toggle_buttons.dart';
import '../../../settings/views/widgets/theme_popup_menu.dart';
import '../../core/views/widgets/universal/animated_hide.dart';

/// A widget that allows us to change some of the theme settings. Intended
/// to be used in a BottomSheet.
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
class BottomSheetSettings extends ConsumerWidget {
  const BottomSheetSettings({super.key});
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
                const ListTile(
                  title: Text('BottomSheet Settings Example'),
                ),
                const ThemePopupMenu(),
                const ListTile(
                  title: Text('Theme mode'),
                  trailing: ThemeModeToggleButtons(),
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
                      DarkIsTrueBlackSwitch(),
                      DarkComputeThemeSwitch(),
                      DarkLevelSlider(),
                    ],
                  ),
                ),
                const Divider(),
                const ListTile(title: Text('AppBar style')),
                ListTile(
                  trailing: isLight
                      ? const LightAppBarStyleToggleButtons()
                      : const DarkAppBarStyleToggleButtons(),
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
