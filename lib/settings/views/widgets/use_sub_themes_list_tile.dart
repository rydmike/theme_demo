import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views/widgets/universal/switch_list_tile_adaptive.dart';
import '../../controllers/settings.dart';

class UseSubThemesListTile extends ConsumerWidget {
  const UseSubThemesListTile({this.title, this.subtitle, super.key});

  final Widget? title;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTileAdaptive(
      title: title,
      subtitle: subtitle,
      value: ref.watch(Settings.useSubThemesProvider),
      onChanged: ref.read(Settings.useSubThemesProvider.notifier).set,
    );
  }
}
