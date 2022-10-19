import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/settings.dart';
import 'surface_mode_popup_menu.dart';

/// Toggle the surface mode of the application for light theme mode.
///
/// This toggle bakes in the Riverpod state provider and is tied to this app
/// implementation. This approach is easy to use since there is nothing to
/// pass around to set its value, just drop in the Widget anywhere in the app.
@immutable
class DarkSurfaceModePopupMenu extends ConsumerWidget {
  const DarkSurfaceModePopupMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SurfaceModePopupMenu(
        title: const Text('Dark theme surface mode'),
        index: ref.watch(Settings.darkSurfaceModeProvider).index,
        onChanged: (int index) {
          ref
              .read(Settings.darkSurfaceModeProvider.notifier)
              .set(FlexSurfaceMode.values[index]);
        });
  }
}
