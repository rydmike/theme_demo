import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/models/app_theme.dart';
import '../../controllers/settings.dart';

// This is a theme selector using a ListTile with a Popup-up menu theme
// selection widget.
class ThemePopupMenu extends ConsumerWidget {
  const ThemePopupMenu({
    super.key,
    this.contentPadding,
  });

  /// The ListTiles tile's internal padding.
  ///
  /// If null, `EdgeInsets.symmetric(horizontal: 16.0)` is used.
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Size of the theme selector with theme colors.
    const double height = 23;
    const double width = height * 1.3;

    final bool isLight = Theme.of(context).brightness == Brightness.light;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final int selected = ref.watch(Settings.schemeIndexProvider);
    final bool useMaterial3 = ref.watch(Settings.useMaterial3Provider);

    // Make our FlexThemeModeOptionButton, used for theme selection, border
    // radius follow the defaults for Card in both M2 and M3 mode, or the
    // sub theme defined global border radius, if it is defined.
    final double optionButtonBorderRadius =
        ref.watch(Settings.useSubThemesProvider)
            // M3 default for Card is 12.
            ? ref.watch(Settings.defaultRadiusProvider) ??
                // M3 or M2 default for Card, if global radius not defined.
                (useMaterial3 ? 12 : 4)
            // Use M3 or M2 default for Card, if not using sub-themes.
            : useMaterial3
                ? 12
                : 4;

    return PopupMenuButton<int>(
      padding: EdgeInsets.zero,
      onSelected: ref.read(Settings.schemeIndexProvider.notifier).set,
      itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
        for (int i = 0; i < AppTheme.schemes.length; i++)
          PopupMenuItem<int>(
            value: i,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(AppTheme.schemes[i].name),
              leading: SizedBox(
                width: width * 2,
                child: FlexThemeModeOptionButton(
                  flexSchemeColor: isLight
                      ? AppTheme.schemes[i].light
                      : AppTheme.schemes[i].dark,
                  selected: selected == i,
                  selectedBorder: BorderSide(
                    color: scheme.onSurfaceVariant,
                    width: 4,
                  ),
                  unselectedBorder: BorderSide.none,
                  backgroundColor: scheme.background,
                  width: width,
                  height: height,
                  padding: EdgeInsets.zero,
                  borderRadius: 0,
                  optionButtonPadding: EdgeInsets.zero,
                  optionButtonMargin: EdgeInsets.zero,
                  optionButtonBorderRadius: optionButtonBorderRadius,
                ),
              ),
            ),
          )
      ],
      child: ListTile(
        contentPadding: contentPadding,
        title: Text('${AppTheme.schemes[selected].name} theme'),
        subtitle: Text(AppTheme.schemes[selected].description),
        trailing: SizedBox(
          width: width * 2,
          child: FlexThemeModeOptionButton(
            flexSchemeColor: FlexSchemeColor(
              primary: scheme.primary,
              primaryContainer: scheme.primaryContainer,
              secondary: scheme.secondary,
              secondaryContainer: scheme.secondaryContainer,
              tertiary: scheme.tertiary,
              tertiaryContainer: scheme.tertiaryContainer,
            ),
            selected: false,
            unselectedBorder: BorderSide.none,
            backgroundColor: scheme.background,
            width: width,
            height: height,
            padding: EdgeInsets.zero,
            borderRadius: 0,
            optionButtonPadding: EdgeInsets.zero,
            optionButtonMargin: EdgeInsets.zero,
            optionButtonBorderRadius: optionButtonBorderRadius,
          ),
        ),
      ),
    );
  }
}
