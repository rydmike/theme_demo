import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/string_case_extensions.dart';
import '../../controllers/settings.dart';
import 'theme_mode_toggle_buttons.dart';

class ThemeModeListTile extends ConsumerWidget {
  const ThemeModeListTile({this.title, super.key});

  final Widget? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode mode = ref.watch(Settings.themeModeProvider);
    return ListTile(
      title: title,
      subtitle: Text(mode.name.sentenceCase()),
      onTap: () {
        switch (ref.read(Settings.themeModeProvider)) {
          case ThemeMode.light:
            ref.read(Settings.themeModeProvider.notifier).set(ThemeMode.system);
            break;
          case ThemeMode.system:
            ref.read(Settings.themeModeProvider.notifier).set(ThemeMode.dark);
            break;
          case ThemeMode.dark:
            ref.read(Settings.themeModeProvider.notifier).set(ThemeMode.light);
            break;
        }
      },
      trailing: const ThemeModeToggleButtons(),
    );
  }
}
