import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/universal/switch_list_tile_adaptive.dart';
import '../../providers/settings_providers.dart';

class DarkThemeComputeSwitch extends ConsumerWidget {
  const DarkThemeComputeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTileAdaptive(
      title: const Text('Compute dark scheme colors'),
      subtitle: const Text(
        'Dark scheme colors are computed from the light scheme, instead of '
        'using defined dark scheme colors.',
      ),
      value: ref.watch(computeDarkThemeProvider),
      onChanged: (bool value) async {
        await ref.read(computeDarkThemeProvider.notifier).set(value);
      },
    );
  }
}
