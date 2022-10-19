import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views/widgets/universal/animated_hide.dart';
import '../../controllers/settings.dart';

class DarkLevelSlider extends ConsumerWidget {
  const DarkLevelSlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedHide(
      hide: !ref.watch(Settings.darkComputeThemeProvider),
      child: ListTile(
        title: Slider.adaptive(
          max: 100,
          divisions: 100,
          label: ref.read(Settings.darkComputeLevelProvider).toString(),
          value: ref.watch(Settings.darkComputeLevelProvider).toDouble(),
          onChanged: (double value) {
            ref
                .read(Settings.darkComputeLevelProvider.notifier)
                .set(value.floor());
          },
        ),
        trailing: Padding(
          padding: const EdgeInsetsDirectional.only(end: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                'LEVEL',
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                '${ref.read(Settings.darkComputeLevelProvider)} %',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
