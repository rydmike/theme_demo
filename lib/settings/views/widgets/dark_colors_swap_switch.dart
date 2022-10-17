import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views/widgets/universal/switch_list_tile_adaptive.dart';
import '../../controllers/settings_providers.dart';

class DarkColorsSwapSwitch extends ConsumerWidget {
  const DarkColorsSwapSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTileAdaptive(
      title: const Text('Dark mode swap colors'),
      subtitle: const Text('Turn ON to swap primary and secondary colors'),
      value: ref.watch(darkSwapColorsProvider),
      onChanged: (bool value) async {
        await ref.read(darkSwapColorsProvider.notifier).set(value);
      },
    );
  }
}
