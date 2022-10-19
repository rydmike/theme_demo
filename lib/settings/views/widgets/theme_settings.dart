import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views/widgets/universal/animated_hide.dart';
import '../../controllers/settings.dart';
import 'app_bar_elevation_slider.dart';
import 'dark_app_bar_style_popup_menu.dart';
import 'dark_colors_swap_switch.dart';
import 'dark_compute_theme_switch.dart';
import 'dark_level_slider.dart';
import 'dark_surface_blend_level_slider.dart';
import 'dark_surface_style_toggle_buttons.dart';
import 'dark_true_black_switch.dart';
import 'light_app_bar_style_popup_menu.dart';
import 'light_colors_swap_switch.dart';
import 'light_surface_blend_level_slider.dart';
import 'light_surface_style_toggle_buttons.dart';
import 'theme_mode_list_tile.dart';
import 'theme_popup_menu.dart';
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
class ThemeSettings extends ConsumerWidget {
  const ThemeSettings({super.key});

  // Explain the used surface mode. This is for dev mode to have an explanation
  // of what the used surface mode. All of these are not used by out control,
  // but if we add them this will cover all of them.
  String explainMode(final FlexSurfaceMode mode) {
    switch (mode) {
      case FlexSurfaceMode.level:
        return 'Flat blend\nAll surfaces at blend level 1x\n';
      case FlexSurfaceMode.highBackgroundLowScaffold:
        return 'High background, low scaffold\n'
            'Background 3/2x  Surface 1x  Scaffold 1/2x\n';
      case FlexSurfaceMode.highSurfaceLowScaffold:
        return 'High surface, low scaffold\n'
            'Surface 3/2x  Background 1x  Scaffold 1/2x\n';
      case FlexSurfaceMode.highScaffoldLowSurface:
        return 'High scaffold, low surface\n'
            'Scaffold 3x  Background 1x  Surface 1/2x\n';
      case FlexSurfaceMode.highScaffoldLevelSurface:
        return 'High scaffold, level surface\n'
            'Scaffold 3x  Background 2x  Surface 1x\n';
      case FlexSurfaceMode.levelSurfacesLowScaffold:
        return 'Level surfaces, low scaffold\n'
            'Surface & Background 1x  Scaffold 1/2x\n';
      case FlexSurfaceMode.highScaffoldLowSurfaces:
        return 'High scaffold, low surfaces\n'
            'Scaffold 3x  Surface and Background 1/2x\n';
      case FlexSurfaceMode.levelSurfacesLowScaffoldVariantDialog:
        return 'Tertiary container dialog, low scaffold\n'
            'Surface & Background 1x  Scaffold 1/2x\n'
            'Dialog 1x blend of tertiary container color';
      case FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog:
        return 'High scaffold, tertiary container dialog\n'
            'Scaffold 3x  Surface and Background 1/2x\n'
            'Dialog 1/2x blend of tertiary container color';
      case FlexSurfaceMode.custom:
        return '';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          ListTile(
            title: const Text('Surface blend mode light'),
            subtitle: Text(
              explainMode(ref.watch(Settings.lightSurfaceModeProvider)),
            ),
          ),
          const ListTile(trailing: LightSurfaceStyleToggleButtons()),
          const ListTile(
            title: Text('Light surface blend level'),
            subtitle: Text('Adjust the surface, background and '
                'scaffold blend level.'),
          ),
          const LightSurfaceBlendLevelSlider(),
        ] else ...<Widget>[
          ListTile(
            title: const Text('Surface blend mode dark'),
            subtitle: Text(
              explainMode(ref.watch(Settings.darkSurfaceModeProvider)),
            ),
          ),
          const ListTile(trailing: DarkSurfaceStyleToggleButtons()),
          const ListTile(
            title: Text('Dark surface blend level'),
            subtitle: Text('Adjust the surface, background and '
                'scaffold blend level.'),
          ),
          const DarkSurfaceBlendLevelSlider(),
        ],
        const Divider(),
        if (isLight)
          const LightAppBarStylePopupMenu()
        else
          const DarkAppBarStylePopupMenu(),
        const AppBarElevationSlider(),
      ],
    );
  }
}
