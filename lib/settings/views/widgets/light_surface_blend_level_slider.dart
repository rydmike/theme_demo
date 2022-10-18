import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/settings.dart';

class LightSurfaceBlendLevelSlider extends ConsumerWidget {
  const LightSurfaceBlendLevelSlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int level = ref.watch(Settings.lightBlendLevelProvider);
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
                ref.read(Settings.lightBlendLevelProvider.notifier).set(
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
