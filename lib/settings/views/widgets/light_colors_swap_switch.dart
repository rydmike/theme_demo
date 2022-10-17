import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views/widgets/universal/switch_list_tile_adaptive.dart';
import '../../controllers/settings_providers.dart';

class LightColorsSwapSwitch extends ConsumerWidget {
  const LightColorsSwapSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTileAdaptive(
      title: const Text('Light mode swap colors'),
      subtitle: const Text('Turn ON to swap primary and secondary colors'),
      value: ref.watch(lightSwapColorsProvider),
      onChanged: (bool value) async {
        await ref.read(lightSwapColorsProvider.notifier).set(value);
      },
    );
  }
}
