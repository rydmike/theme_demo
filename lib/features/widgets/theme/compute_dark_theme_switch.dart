import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/theme_providers.dart';

class ComputeDarkThemeSwitch extends ConsumerWidget {
  const ComputeDarkThemeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile.adaptive(
      title: const Text('Compute dark scheme colors'),
      subtitle: const Text(
        'Dark scheme colors are computed from the light scheme, instead of '
        'using defined dark scheme colors.',
      ),
      value: ref.watch(computeDarkThemeProvider),
      onChanged: (bool value) =>
          ref.read(computeDarkThemeProvider.state).state = value,
    );
  }
}
