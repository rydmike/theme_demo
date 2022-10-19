import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/models/app_theme.dart';
import '../../controllers/settings.dart';
import 'app_bar_style_popup_menu.dart';

/// Toggle the AppBar style of the application for light theme mode.
///
/// This toggle bakes in the Riverpod state provider and is tied to this app
/// implementation. This approach is easy to use since there is nothing to
/// pass around to set its value, just drop in the Widget anywhere in the app.
@immutable
class LightAppBarStylePopupMenu extends ConsumerWidget {
  const LightAppBarStylePopupMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBarStylePopupMenu(
      title: const Text('Light theme AppBarStyle'),
      labelForDefault: 'default',
      index: ref.watch(Settings.lightAppBarStyleProvider)?.index ?? -1,
      onChanged: (int index) {
        if (index < 0 || index >= FlexAppBarStyle.values.length) {
          ref.read(Settings.lightAppBarStyleProvider.notifier).set(null);
        } else {
          ref
              .read(Settings.lightAppBarStyleProvider.notifier)
              .set(FlexAppBarStyle.values[index]);
        }
      },
      // To access the custom color we defined for AppBars in this
      // PopupMenuButton widget, we have to pass it along, or the
      // entire controller. We chose the color in this case. It is not
      // carried with the theme, so we cannot get it from there in
      // the widget. FlexColorScheme knows the color when
      // you make a theme with it. This color is used to show the
      // correct color on the AppBar custom color option for the not
      // built-in custom color schemes.
      // In our examples we only actually have custom app bar
      // colors in the three custom color examples, and we want to
      // show them as well on the PopupMenu button.
      customAppBarColor: AppTheme
          .schemes[ref.watch(Settings.schemeIndexProvider)].light.appBarColor,
    );
  }
}
