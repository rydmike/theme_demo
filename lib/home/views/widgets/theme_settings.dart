import 'package:flutter/material.dart';

import '../../../core/views/widgets/universal/animated_hide.dart';
import '../../../settings/views/widgets/app_bar_elevation_slider.dart';
import '../../../settings/views/widgets/dark_app_bar_opacity.dart';
import '../../../settings/views/widgets/dark_app_bar_style_popup_menu.dart';
import '../../../settings/views/widgets/dark_colors_swap_switch.dart';
import '../../../settings/views/widgets/dark_compute_theme_switch.dart';
import '../../../settings/views/widgets/dark_level_slider.dart';
import '../../../settings/views/widgets/dark_surface_blend_level_slider.dart';
import '../../../settings/views/widgets/dark_surface_mode_list_tile.dart';
import '../../../settings/views/widgets/dark_surface_mode_popup_menu.dart';
import '../../../settings/views/widgets/dark_true_black_switch.dart';
import '../../../settings/views/widgets/light_app_bar_opacity.dart';
import '../../../settings/views/widgets/light_app_bar_style_popup_menu.dart';
import '../../../settings/views/widgets/light_colors_swap_switch.dart';
import '../../../settings/views/widgets/light_surface_blend_level_slider.dart';
import '../../../settings/views/widgets/light_surface_mode_list_tile.dart';
import '../../../settings/views/widgets/light_surface_mode_popup_menu.dart';
import '../../../settings/views/widgets/theme_mode_list_tile.dart';
import '../../../settings/views/widgets/theme_popup_menu.dart';
import '../../../settings/views/widgets/transparent_status_bar_switch.dart';
import '../../../settings/views/widgets/use_material3_switch.dart';

/// A Column widget that allows us to change all app used theme settings.
///
/// The widgets we use to control the theme use Riverpod StateNotifierProviders.
/// The StateNotifierProviders persist their settings with selected
/// KeyValueDb implementation. They also modify the theme provider and thus
/// change the theme interactively.
///
/// The Flutter SDK theme handles the animation between theme changes, its
/// properties lerp between values and use animated theme automatically.
class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    return Column(
      children: <Widget>[
        const ThemeModeListTile(title: Text('Theme mode')),
        const UseMaterial3Switch(),
        const ThemePopupMenu(),

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
        if (isLight) ...<Widget>[
          const LightSurfaceModePopupMenu(),
          const LightSurfaceModeListTile(),
          const ListTile(
            title: Text('Light surface blend'),
            subtitle: Text('Adjust the surface, background and '
                'scaffold blends'),
          ),
          const LightSurfaceBlendLevelSlider(),
        ] else ...<Widget>[
          const DarkSurfaceModePopupMenu(),
          const DarkSurfaceModeListTile(),
          const ListTile(
            title: Text('Dark surface blend'),
            subtitle: Text('Adjust the surface, background and '
                'scaffold blends'),
          ),
          const DarkSurfaceBlendLevelSlider(),
        ],
        const Divider(),
        const AppBarElevationSlider(),
        if (isLight) ...<Widget>[
          const LightAppBarStylePopupMenu(),
          const LightAppBarOpacitySlider(),
        ] else ...<Widget>[
          const DarkAppBarStylePopupMenu(),
          const DarkAppBarOpacitySlider(),
        ],
        const TransparentStatusBarSwitch(),
      ],
    );
  }
}
