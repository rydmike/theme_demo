import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/theme_providers.dart';
import '../animated_hide.dart';

class DarkLevelSlider extends ConsumerWidget {
  const DarkLevelSlider({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedHide(
      hide: !ref.watch(computeDarkThemeProvider),
      child: ListTile(
        title: Slider.adaptive(
          max: 100,
          divisions: 100,
          label: ref.read(darkLevelProvider).toString(),
          value: ref.watch(darkLevelProvider).toDouble(),
          onChanged: (double value) {
            ref.read(darkLevelProvider.state).state = value.floor();
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
                '${ref.read(darkLevelProvider)} %',
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
