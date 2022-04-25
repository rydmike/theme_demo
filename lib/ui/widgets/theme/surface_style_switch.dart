import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/theme_providers.dart';
import '../../../utils/app_icons.dart';

/// Toggle the surface style of the application.
///
/// This toggle bakes in the Riverpod state provider and is tied to this app
/// implementation. This approach is easy to use since there is nothing to
/// pass around to set its value, just drop in the Widget anywhere in the app.
@immutable
class SurfaceStyleSwitch extends ConsumerWidget {
  const SurfaceStyleSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final FlexSurface surface = ref.watch(surfaceStyleProvider);
    final MaterialColor primarySwatch =
        FlexColorScheme.createPrimarySwatch(theme.colorScheme.primary);
    final List<bool> isSelected = <bool>[
      surface == FlexSurface.material,
      surface == FlexSurface.light,
      surface == FlexSurface.medium,
      surface == FlexSurface.strong,
      surface == FlexSurface.heavy,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        ref.read(surfaceStyleProvider.state).state =
            FlexSurface.values[newIndex];
      },
      children: <Widget>[
        Icon(AppIcons.defaultSurface,
            color: surface == FlexSurface.material
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.primary),
        Icon(AppIcons.customSurface,
            color: surface == FlexSurface.light
                ? primarySwatch.shade50.lighten(20)
                : primarySwatch.shade50),
        Icon(AppIcons.customSurface,
            color: surface == FlexSurface.medium
                ? primarySwatch.shade50 //.lighten(15)
                : primarySwatch.shade200),
        Icon(AppIcons.customSurface,
            color: surface == FlexSurface.strong
                ? primarySwatch.shade800
                : primarySwatch.shade400),
        Icon(AppIcons.customSurface,
            color: surface == FlexSurface.heavy
                ? primarySwatch.shade900
                : primarySwatch.shade600),
      ],
    );
  }
}
