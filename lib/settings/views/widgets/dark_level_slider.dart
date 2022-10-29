import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views/widgets/universal/animated_hide.dart';
import '../../controllers/settings.dart';

class DarkLevelSlider extends ConsumerWidget {
  const DarkLevelSlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextStyle style = Theme.of(context).textTheme.bodySmall!;
    final int level = ref.watch(Settings.darkComputeLevelProvider);
    return AnimatedHide(
      hide: !ref.watch(Settings.darkComputeThemeProvider) ||
          ref.watch(Settings.usePrimaryKeyColorProvider),
      child: ListTile(
        title: Slider.adaptive(
          max: 100,
          divisions: 100,
          label: level.toString(),
          value: level.roundToDouble(),
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
                style: style,
              ),
              Text(
                '$level %',
                style: style.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
