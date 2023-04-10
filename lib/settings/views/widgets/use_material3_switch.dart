import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/settings.dart';

class UseMaterial3Switch extends ConsumerWidget {
  const UseMaterial3Switch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
      title: const Text('Use Material 3'),
      value: ref.watch(Settings.useMaterial3Provider),
      onChanged: ref.read(Settings.useMaterial3Provider.notifier).set,
    );
  }
}
