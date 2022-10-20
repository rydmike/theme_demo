import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/settings.dart';
import 'surface_mode_widgets.dart';

class LightSurfaceModeToggleButtons extends ConsumerWidget {
  const LightSurfaceModeToggleButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SurfaceModeToggleButtons(
      mode: ref.watch(Settings.lightSurfaceModeProvider),
      onChanged: ref.read(Settings.lightSurfaceModeProvider.notifier).set,
    );
  }
}
