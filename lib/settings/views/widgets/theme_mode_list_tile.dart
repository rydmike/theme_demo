import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/settings.dart';
import 'theme_mode_toggle_buttons.dart';

class ThemeModeListTile extends ConsumerWidget {
  const ThemeModeListTile({this.title, super.key});

  final Widget? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: title,
      onTap: () {
        if (ref.read(Settings.themeModeProvider) != ThemeMode.light) {
          ref.read(Settings.themeModeProvider.notifier).set(ThemeMode.light);
        } else {
          ref.read(Settings.themeModeProvider.notifier).set(ThemeMode.dark);
        }
      },
      trailing: const ThemeModeToggleButtons(),
    );
  }
}
