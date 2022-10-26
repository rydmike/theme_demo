import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views/widgets/universal/animated_hide.dart';
import '../../../settings/controllers/settings.dart';
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
import '../../../settings/views/widgets/default_border_radius_slider.dart';
import '../../../settings/views/widgets/flex_tone_config_popup_menu.dart';
import '../../../settings/views/widgets/light_app_bar_opacity.dart';
import '../../../settings/views/widgets/light_app_bar_style_popup_menu.dart';
import '../../../settings/views/widgets/light_colors_swap_switch.dart';
import '../../../settings/views/widgets/light_surface_blend_level_slider.dart';
import '../../../settings/views/widgets/light_surface_mode_list_tile.dart';
import '../../../settings/views/widgets/light_surface_mode_popup_menu.dart';
import '../../../settings/views/widgets/theme_mode_list_tile.dart';
import '../../../settings/views/widgets/theme_popup_menu.dart';
import '../../../settings/views/widgets/transparent_status_bar_switch.dart';
import '../../../settings/views/widgets/use_key_colors_toggle_buttons.dart';
import '../../../settings/views/widgets/use_material3_switch.dart';
import '../../../settings/views/widgets/use_sub_themes_list_tile.dart';
import '../../../theme/models/flex_tone.dart';

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    final bool useSubThemes = ref.watch(Settings.useSubThemesProvider);
    final bool useSeed = ref.watch(Settings.usePrimaryKeyColorProvider);
    final int flexTone = ref.watch(Settings.usedFlexToneProvider);
    final int usedFlexTone =
        flexTone < 0 || flexTone >= FlexTone.values.length || !useSeed
            ? 0
            : flexTone;

    final String explainM3Surface = useSeed
        ? '. With seeded ColorScheme, for a pure M3 surface design, use level 0'
        : '';

    return Column(
      children: <Widget>[
        const ThemeModeListTile(title: Text('Theme mode')),
        const UseMaterial3Switch(),
        const UseSubThemesListTile(
          title: Text('Use component themes'),
          subtitle: Text('Enable FlexColorScheme opinionated sub themes'),
        ),
        AnimatedHide(
          hide: !useSubThemes,
          child: Column(
            children: const <Widget>[
              ListTile(
                title: Text('Global border radius on components'),
                subtitle: Text(
                  'Default setting uses mostly Material 3 design '
                  'values, where radius spec varies per component. '
                  'Material 2 design uses 4 on all components.',
                ),
              ),
              DefaultBorderRadiusSlider(),
            ],
          ),
        ),
        const Divider(),
        const ThemePopupMenu(),
        if (isLight)
          const LightColorsSwapSwitch()
        else
          const DarkColorsSwapSwitch(),
        const Divider(),

        const ListTileExplainUsedSeed(),
        const ListTile(trailing: UseKeyColorsToggleButtons()),
        AnimatedHide(
          hide: !useSeed,
          child: Column(
            children: <Widget>[
              const ListTile(
                subtitle: Text(
                  'Use FlexTones to configure which tone from '
                  'generated palettes each color in the ColorScheme use. '
                  'Set limits on used CAM16 chroma values '
                  'for the three colors used as keys for primary, '
                  'secondary and tertiary TonalPalettes. '
                  'In this app you can choose between the default Material 3 '
                  'tone mapping plus six pre-defined custom FlexTones setups.',
                ),
              ),
              FlexToneConfigPopupMenu(
                title: 'FlexTones setup',
                index: useSeed ? usedFlexTone : 0,
                onChanged: useSeed
                    ? ref.read(Settings.usedFlexToneProvider.notifier).set
                    : null,
              ),
              ListTile(
                title: Text('${FlexTone.values[usedFlexTone].tone}'
                    ' FlexTones setup with CAM16 chroma'),
                subtitle: Text(FlexTone.values[usedFlexTone].setup),
              ),
            ],
          ),
        ),
        // Hide the extra dark mode controls in light theme.
        AnimatedHide(
          hide: isLight,
          child: Column(
            children: <Widget>[
              const DarkIsTrueBlackSwitch(),
              AnimatedHide(
                hide: useSeed,
                child: const DarkComputeThemeSwitch(),
              ),
              const DarkLevelSlider(),
            ],
          ),
        ),
        const Divider(),
        if (isLight) ...<Widget>[
          const LightSurfaceModePopupMenu(),
          const LightSurfaceModeListTile(),
          ListTile(
            title: const Text('Light surface blend'),
            subtitle: Text('Adjust the surface, background and '
                'scaffold blends$explainM3Surface'),
          ),
          const LightSurfaceBlendLevelSlider(),
        ] else ...<Widget>[
          const DarkSurfaceModePopupMenu(),
          const DarkSurfaceModeListTile(),
          ListTile(
            title: const Text('Dark surface blend'),
            subtitle: Text('Adjust the surface, background and '
                'scaffold blends$explainM3Surface'),
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
