import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/settings.dart';
import 'light_surface_mode_toggle_buttons.dart';

class LightSurfaceModeListTile extends ConsumerWidget {
  const LightSurfaceModeListTile({this.title, this.subtitle, super.key});

  final Widget? title;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FlexSurfaceMode mode = ref.watch(Settings.lightSurfaceModeProvider);
    return ListTile(
      title: title,
      subtitle: subtitle,
      onTap: () {
        // We skip the last custom item and go to start again before it.
        if (mode.index + 1 >= FlexSurfaceMode.values.length - 1) {
          ref
              .read(Settings.lightSurfaceModeProvider.notifier)
              .set(FlexSurfaceMode.values[0]);
        } else {
          ref
              .read(Settings.lightSurfaceModeProvider.notifier)
              .set(FlexSurfaceMode.values[mode.index + 1]);
        }
      },
      trailing: const LightSurfaceModeToggleButtons(),
    );
  }
}
