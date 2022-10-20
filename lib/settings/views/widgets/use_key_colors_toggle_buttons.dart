import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/settings.dart';

// ToggleButtons used to change usage of key colors for seeded
// color scheme generation.
//
// ToggleButtons are great since you can easily implement totally
// custom toggle logic with them, like used here to fulfill a custom toggling
// need, where first button turns off all, but 2nd and 3rd button can be toggled
// individually.
class UseKeyColorsToggleButtons extends ConsumerWidget {
  const UseKeyColorsToggleButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool useSeed = ref.watch(Settings.usePrimaryKeyColorProvider);
    final bool useSecondary = ref.watch(Settings.useSecondaryKeyColorProvider);
    final bool useTertiary = ref.watch(Settings.useTertiaryKeyColorProvider);
    final List<bool> isSelected = <bool>[
      useSeed,
      useSeed && useSecondary,
      useSeed && useTertiary,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int index) {
        if (index == 0) {
          ref
              .read(Settings.usePrimaryKeyColorProvider.notifier)
              .set(!ref.read(Settings.usePrimaryKeyColorProvider));
        }
        if (index == 1 && useSeed) {
          ref
              .read(Settings.useSecondaryKeyColorProvider.notifier)
              .set(!ref.read(Settings.useSecondaryKeyColorProvider));
        }
        if (index == 2 && useSeed) {
          ref
              .read(Settings.useTertiaryKeyColorProvider.notifier)
              .set(!ref.read(Settings.useTertiaryKeyColorProvider));
        }
      },
      children: <Widget>[
        const Tooltip(
          message: 'Use light theme Primary color\n'
              'as key color to seed your ColorScheme',
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Primary', style: TextStyle(fontSize: 12)),
          ),
        ),
        Visibility(
          visible: useSeed,
          maintainSize: true,
          maintainState: true,
          maintainAnimation: true,
          child: const Tooltip(
            message: 'Use light theme Secondary color\n'
                'as key color to seed your ColorScheme',
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Secondary', style: TextStyle(fontSize: 12)),
            ),
          ),
        ),
        Visibility(
          visible: useSeed,
          maintainSize: true,
          maintainState: true,
          maintainAnimation: true,
          child: const Tooltip(
            message: 'Use light theme Tertiary color\n'
                'as key color to seed your ColorScheme',
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Tertiary', style: TextStyle(fontSize: 12)),
            ),
          ),
        ),
      ],
    );
  }
}

/// A list tile to explain the currently used M3 seeded ColorScheme mode.
class ListTileExplainUsedSeed extends ConsumerWidget {
  const ListTileExplainUsedSeed({
    super.key,
  });

  /// Explain the current selection of key colors used to
  /// generate the ColorScheme, when it is activated.
  String explainUsedColors(WidgetRef ref) {
    final bool useSeed = ref.watch(Settings.usePrimaryKeyColorProvider);
    final bool useSecondary = ref.watch(Settings.useSecondaryKeyColorProvider);
    final bool useTertiary = ref.watch(Settings.useTertiaryKeyColorProvider);
    if (!useSeed) {
      return 'Material 3 ColorScheme seeding from key colors is OFF and not '
          'used. The ColorScheme is based directly on the selected theme';
    }
    if (!useSecondary && !useTertiary) {
      return 'Light theme Primary color is used to generate the Colorscheme. '
          'This is like using Flutter ColorScheme.fromSeed with the Primary '
          'color as seed color';
    }
    if (useSecondary && !useTertiary) {
      return 'Tonal palettes for the ColorScheme, are made with light theme '
          'Primary and Secondary colors as seed keys. Tertiary key is computed '
          'from Primary color';
    }
    if (!useSecondary && useTertiary) {
      return 'Tonal palettes for the ColorScheme, are made with light theme '
          'Primary and Tertiary colors as seed keys, Secondary key is computed '
          'from Primary color';
    }
    return 'Light theme Primary, Secondary and Tertiary colors are used as '
        'keys to generate tonal palettes that define the ColorScheme';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: const Text('Use light theme colors to seed the ColorScheme'),
      subtitle: Text(explainUsedColors(ref)),
    );
  }
}
