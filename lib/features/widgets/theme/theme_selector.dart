import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/theme_providers.dart';
import '../../../utils/app_insets.dart';
import '../../../utils/app_theme.dart';

// This is a theme selector using a ListTile with a Popup-up menu theme
// selection widget.
class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({
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
    final int selected = ref.watch(schemeProvider);

    return PopupMenuButton<int>(
      padding: EdgeInsets.zero,
      onSelected: (int newTheme) {
        ref.read(schemeProvider.state).state = newTheme;
      },
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
                  selected: true,
                  selectedBorder: BorderSide(
                    color: isLight
                        ? AppTheme.schemes[i].light.primary
                        : AppTheme.schemes[i].dark.primary,
                    width: AppInsets.outlineThickness,
                  ),
                  backgroundColor: scheme.background,
                  width: width,
                  height: height,
                  padding: EdgeInsets.zero,
                  borderRadius: 0,
                  optionButtonPadding: EdgeInsets.zero,
                  optionButtonMargin: EdgeInsets.zero,
                  optionButtonBorderRadius: AppInsets.cornerRadius,
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
              tertiary: scheme.tertiary,
            ),
            selected: true,
            selectedBorder: BorderSide(
              color: scheme.primary,
              width: AppInsets.outlineThickness,
            ),
            backgroundColor: scheme.background,
            width: width,
            height: height,
            padding: EdgeInsets.zero,
            borderRadius: 0,
            optionButtonPadding: EdgeInsets.zero,
            optionButtonMargin: EdgeInsets.zero,
            optionButtonBorderRadius: AppInsets.cornerRadius,
          ),
        ),
      ),
    );
  }
}
