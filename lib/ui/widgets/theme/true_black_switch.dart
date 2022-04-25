import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/theme_providers.dart';

class TrueBlackSwitch extends ConsumerWidget {
  const TrueBlackSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile.adaptive(
      title: const Text('Use true black'),
      value: ref.watch(darkIsTrueBlackProvider),
      onChanged: (bool value) {
        ref.read(darkIsTrueBlackProvider.state).state = value;
      },
    );
  }
}
