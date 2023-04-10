import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/settings.dart';

class DarkColorsSwapSwitch extends ConsumerWidget {
  const DarkColorsSwapSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
      title: const Text('Swap colors'),
      subtitle: const Text('Swap primary and secondary dark colors'),
      value: ref.watch(Settings.darkSwapColorsProvider),
      onChanged: ref.read(Settings.darkSwapColorsProvider.notifier).set,
    );
  }
}
