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
class ThemeModeSwitch extends ConsumerWidget {
  const ThemeModeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode themeMode = ref.watch(themeModeProvider);
    final List<bool> isSelected = <bool>[
      themeMode == ThemeMode.light,
      themeMode == ThemeMode.system,
      themeMode == ThemeMode.dark,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        if (newIndex == 0) {
          ref.read(themeModeProvider.state).state = ThemeMode.light;
        } else if (newIndex == 1) {
          ref.read(themeModeProvider.state).state = ThemeMode.system;
        } else {
          ref.read(themeModeProvider.state).state = ThemeMode.dark;
        }
      },
      children: const <Widget>[
        Icon(AppIcons.lightTheme),
        Icon(AppIcons.systemTheme),
        Icon(AppIcons.darkTheme),
      ],
    );
  }
}
