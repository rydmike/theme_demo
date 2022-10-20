import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/settings.dart';
import 'surface_mode_widgets.dart';

class DarkSurfaceModeToggleButtons extends ConsumerWidget {
  const DarkSurfaceModeToggleButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SurfaceModeToggleButtons(
      mode: ref.watch(Settings.darkSurfaceModeProvider),
      onChanged: ref.read(Settings.darkSurfaceModeProvider.notifier).set,
    );
  }
}
