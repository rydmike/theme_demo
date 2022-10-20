import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/models/app_theme.dart';
import '../../controllers/settings.dart';
import 'app_bar_style_popup_menu.dart';

/// Toggle the AppBar style of the application for dark theme mode.
///
/// This toggle bakes in the Riverpod state provider and is tied to this app
/// implementation. This approach is easy to use since there is nothing to
/// pass around to set its value, just drop in the Widget anywhere in the app.
@immutable
class DarkAppBarStylePopupMenu extends ConsumerWidget {
  const DarkAppBarStylePopupMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBarStylePopupMenu(
      title: const Text('Dark AppBar style'),
      labelForDefault: 'Default',
      index: ref.watch(Settings.darkAppBarStyleProvider)?.index ?? -1,
      onChanged: (int index) {
        if (index < 0 || index >= FlexAppBarStyle.values.length) {
          ref.read(Settings.darkAppBarStyleProvider.notifier).set(null);
        } else {
          ref
              .read(Settings.darkAppBarStyleProvider.notifier)
              .set(FlexAppBarStyle.values[index]);
        }
      },
      customAppBarColor: AppTheme
          .schemes[ref.watch(Settings.schemeIndexProvider)].dark.appBarColor,
    );
  }
}
