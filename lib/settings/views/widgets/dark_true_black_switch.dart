import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views/widgets/universal/switch_list_tile_adaptive.dart';
import '../../controllers/settings.dart';

class DarkIsTrueBlackSwitch extends ConsumerWidget {
  const DarkIsTrueBlackSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTileAdaptive(
      title: const Text('Use true black'),
      value: ref.watch(Settings.darkIsTrueBlackProvider),
      onChanged: ref.read(Settings.darkIsTrueBlackProvider.notifier).set,
    );
  }
}
