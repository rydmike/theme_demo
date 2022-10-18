import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/settings.dart';

class DarkSurfaceBlendLevelSlider extends ConsumerWidget {
  const DarkSurfaceBlendLevelSlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int level = ref.watch(Settings.darkBlendLevelProvider);
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Slider.adaptive(
              min: 0,
              max: 40,
              divisions: 40,
              label: level.toString(),
              value: level.toDouble(),
              onChanged: (double value) {
                ref.read(Settings.darkBlendLevelProvider.notifier).set(
                      value.toInt(),
                    );
              }),
        ],
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              'Level',
              style: textTheme.caption,
            ),
            Text(
              level.toString(),
              style: textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
