import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/settings_providers.dart';

/// Toggle the surface mode of the application.
///
/// This toggle bakes in the Riverpod state provider and is tied to this app
/// implementation. This approach is easy to use since there is nothing to
/// pass around to set its value, just drop in the Widget anywhere in the app.
@immutable
class LightSurfaceStyleToggleButtons extends ConsumerWidget {
  const LightSurfaceStyleToggleButtons({
    super.key,
    this.showAllModes = true,
  });

  final bool showAllModes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final FlexSurfaceMode mode = ref.watch(lightSurfaceModeProvider);
    final List<bool> isSelected = <bool>[
      mode == FlexSurfaceMode.level,
      mode == FlexSurfaceMode.highBackgroundLowScaffold,
      mode == FlexSurfaceMode.highSurfaceLowScaffold,
      mode == FlexSurfaceMode.highScaffoldLowSurface,
      // Only show this blend option if show all set, not enough room.
      if (showAllModes) mode == FlexSurfaceMode.highScaffoldLevelSurface,
      mode == FlexSurfaceMode.levelSurfacesLowScaffold,
      mode == FlexSurfaceMode.highScaffoldLowSurfaces,
      // Only have these blend options if show all set, not enough room.
      if (showAllModes)
        mode == FlexSurfaceMode.levelSurfacesLowScaffoldVariantDialog,
      if (showAllModes)
        mode == FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
    ];
    final List<FlexSurfaceMode> option = <FlexSurfaceMode>[
      FlexSurfaceMode.level,
      FlexSurfaceMode.highBackgroundLowScaffold,
      FlexSurfaceMode.highSurfaceLowScaffold,
      FlexSurfaceMode.highScaffoldLowSurface,
      // Only have this blend option if show all set, not enough room.
      if (showAllModes) FlexSurfaceMode.highScaffoldLevelSurface,
      FlexSurfaceMode.levelSurfacesLowScaffold,
      FlexSurfaceMode.highScaffoldLowSurfaces,
      // Only have these blend options if show all set, not enough room.
      if (showAllModes) FlexSurfaceMode.levelSurfacesLowScaffoldVariantDialog,
      if (showAllModes) FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) async {
        await ref.read(lightSurfaceModeProvider.notifier).set(
              option[newIndex],
            );
      },
      children: <Widget>[
        const Tooltip(
          message: 'Flat\nall at same level',
          child: Icon(Icons.check_box_outline_blank),
        ),
        const Tooltip(
          message: 'High background\nlow scaffold',
          child: Icon(Icons.layers_outlined),
        ),
        const Tooltip(
          message: 'High surface\nlow scaffold',
          child: Icon(Icons.layers),
        ),
        Tooltip(
          message: 'High scaffold\nlow surface',
          child: Stack(
            alignment: Alignment.center,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Icon(Icons.layers_outlined),
              ),
              Icon(Icons.layers),
            ],
          ),
        ),
        if (showAllModes)
          const Tooltip(
            message: 'High scaffold\nlevel surface',
            child: Icon(Icons.dynamic_feed_rounded),
          ),
        const Tooltip(
          message: 'Level surfaces\nlow scaffold',
          child:
              RotatedBox(quarterTurns: 2, child: Icon(Icons.horizontal_split)),
        ),
        const Tooltip(
          message: 'High scaffold\nlow surfaces (default)',
          child: Icon(Icons.horizontal_split),
        ),
        if (showAllModes)
          Tooltip(
            message: 'Tertiary container dialog\nlow scaffold',
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                const RotatedBox(
                    quarterTurns: 2, child: Icon(Icons.horizontal_split)),
                Icon(Icons.stop, color: scheme.tertiary, size: 18),
              ],
            ),
          ),
        if (showAllModes)
          Tooltip(
            message: 'High scaffold\ntertiary container dialog',
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                const Icon(Icons.horizontal_split),
                Icon(Icons.stop, color: scheme.tertiary, size: 18),
              ],
            ),
          ),
      ],
    );
  }
}
