import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/app_icons.dart';
import '../../controllers/settings.dart';

/// Toggle the AppBar style of the application for dark theme mode.
///
/// This toggle bakes in the Riverpod state provider and is tied to this app
/// implementation. This approach is easy to use since there is nothing to
/// pass around to set its value, just drop in the Widget anywhere in the app.
@immutable
class DarkAppBarStyleToggleButtons extends ConsumerWidget {
  const DarkAppBarStyleToggleButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final FlexAppBarStyle style = ref.watch(Settings.darkAppBarStyleProvider);
    final MaterialColor primarySwatch =
        FlexColorScheme.createPrimarySwatch(colorScheme.primary);
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
        ref
            .read(Settings.darkAppBarStyleProvider.notifier)
            .set(FlexAppBarStyle.values[newIndex]);
      },
      children: <Widget>[
        Icon(AppIcons.appbarColored,
            color: style == FlexAppBarStyle.primary
                ? primarySwatch.shade900
                : theme.colorScheme.primary),
        Icon(AppIcons.appbarSurface,
            color: style == FlexAppBarStyle.material
                ? Colors.black87
                : primarySwatch.shade800),
        Icon(AppIcons.appbarColored,
            color: Color.alphaBlend(
                colorScheme.primary.withAlpha(60), Colors.black)),
        Icon(AppIcons.appbarColored,
            color: Color.alphaBlend(
                colorScheme.primary.withAlpha(90), Colors.black)),
        Icon(AppIcons.appbarColored, color: colorScheme.secondary),
      ],
    );
  }
}
