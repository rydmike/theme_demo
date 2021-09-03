import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theme_demo/providers/theme_providers.dart';
import 'package:theme_demo/utils/app_icons.dart';

/// Toggle the AppBar style of the application for dark theme mode.
///
/// This toggle bakes in the Riverpod state provider and is tied to this app
/// implementation. This approach is easy to use since there is nothing to
/// pass around to set its value, just drop in the Widget anywhere in the app.
@immutable
class DarkAppBarStyleSwitch extends ConsumerWidget {
  const DarkAppBarStyleSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final FlexAppBarStyle style = ref.watch(darkAppBarStyleProvider).state;
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
        ref.read(darkAppBarStyleProvider).state =
            FlexAppBarStyle.values[newIndex];
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
        Icon(AppIcons.appbarColored, color: colorScheme.secondaryVariant),
      ],
    );
  }
}
