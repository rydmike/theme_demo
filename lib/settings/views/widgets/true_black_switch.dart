import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views/widgets/universal/switch_list_tile_adaptive.dart';
import '../../controllers/settings_providers.dart';

class TrueBlackSwitch extends ConsumerWidget {
  const TrueBlackSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTileAdaptive(
      title: const Text('Use true black'),
      value: ref.watch(darkIsTrueBlackProvider),
      onChanged: (bool value) async {
        await ref.read(darkIsTrueBlackProvider.notifier).set(value);
      },
    );
  }
}
