import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/app_icons.dart';
import '../../controllers/settings.dart';

/// Toggle the AppBar style of the application for light theme mode.
///
/// This toggle bakes in the Riverpod state provider and is tied to this app
/// implementation. This approach is easy to use since there is nothing to
/// pass around to set its value, just drop in the Widget anywhere in the app.
@immutable
class LightAppBarStyleToggleButtons extends ConsumerWidget {
  const LightAppBarStyleToggleButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final FlexAppBarStyle style = ref.watch(Settings.lightAppBarStyleProvider);
    final MaterialColor primarySwatch =
        FlexColorScheme.createPrimarySwatch(theme.colorScheme.primary);
    final List<bool> isSelected = <bool>[
      style == FlexAppBarStyle.primary,
      style == FlexAppBarStyle.material,
      style == FlexAppBarStyle.surface,
      style == FlexAppBarStyle.background,
      style == FlexAppBarStyle.custom,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        ref.read(Settings.lightAppBarStyleProvider.notifier).set(
              FlexAppBarStyle.values[newIndex],
            );
      },
      children: <Widget>[
        Icon(AppIcons.appbarColored,
            color: style == FlexAppBarStyle.primary
                ? primarySwatch.shade800
                : theme.colorScheme.primary),
        Icon(AppIcons.appbarSurface,
            color: style == FlexAppBarStyle.material
                ? Colors.white
                : primarySwatch.shade50),
        Icon(AppIcons.appbarColored,
            color: Color.alphaBlend(
                theme.colorScheme.primary.withAlpha(40), Colors.white)),
        Icon(AppIcons.appbarColored,
            color: Color.alphaBlend(
                theme.colorScheme.primary.withAlpha(100), Colors.white)),
        Icon(AppIcons.appbarColored, color: theme.colorScheme.secondary),
      ],
    );
  }
}
