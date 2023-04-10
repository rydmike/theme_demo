import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/settings.dart';

class LightColorsSwapSwitch extends ConsumerWidget {
  const LightColorsSwapSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
      title: const Text('Swap colors'),
      subtitle: const Text('Swap primary and secondary light colors'),
      value: ref.watch(Settings.lightSwapColorsProvider),
      onChanged: ref.read(Settings.lightSwapColorsProvider.notifier).set,
    );
  }
}
