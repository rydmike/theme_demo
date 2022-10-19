import 'package:flutter/material.dart';

import '../../../core/views/widgets/universal/animated_hide.dart';
import 'app_bar_elevation_slider.dart';
import 'dark_app_bar_opacity.dart';
import 'dark_app_bar_style_popup_menu.dart';
import 'dark_colors_swap_switch.dart';
import 'dark_compute_theme_switch.dart';
import 'dark_level_slider.dart';
import 'dark_surface_blend_level_slider.dart';
import 'dark_surface_mode_popup_menu.dart';
import 'dark_surface_mode_toggle_buttons.dart';
import 'dark_true_black_switch.dart';
import 'light_app_bar_opacity.dart';
import 'light_app_bar_style_popup_menu.dart';
import 'light_colors_swap_switch.dart';
import 'light_surface_blend_level_slider.dart';
import 'light_surface_mode_popup_menu.dart';
import 'light_surface_mode_toggle_buttons.dart';
import 'theme_mode_list_tile.dart';
import 'theme_popup_menu.dart';
import 'transparent_status_bar_switch.dart';
import 'use_material3_switch.dart';

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
        const UseMaterial3Switch(),
        const ThemePopupMenu(),
        const ThemeModeListTile(title: Text('Theme mode')),
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
          const ListTile(trailing: LightSurfaceModeToggleButtons()),
          const ListTile(
            title: Text('Light surface blend level'),
            subtitle: Text('Adjust the surface, background and '
                'scaffold blend level.'),
          ),
          const LightSurfaceBlendLevelSlider(),
        ] else ...<Widget>[
          const DarkSurfaceModePopupMenu(),
          const ListTile(trailing: DarkSurfaceModeToggleButtons()),
          const ListTile(
            title: Text('Dark surface blend level'),
            subtitle: Text('Adjust the surface, background and '
                'scaffold blend level.'),
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
