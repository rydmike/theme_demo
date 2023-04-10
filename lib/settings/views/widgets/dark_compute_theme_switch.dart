import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/settings.dart';

class DarkComputeThemeSwitch extends ConsumerWidget {
  const DarkComputeThemeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
      title: const Text('Compute dark scheme colors'),
      subtitle: const Text(
        'Dark scheme colors are computed from the light scheme, instead of '
        'using defined dark scheme colors.',
      ),
      value: ref.watch(Settings.darkComputeThemeProvider),
      onChanged: ref.read(Settings.darkComputeThemeProvider.notifier).set,
    );
  }
}
