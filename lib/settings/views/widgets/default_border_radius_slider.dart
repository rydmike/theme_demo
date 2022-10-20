import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/settings.dart';

class DefaultBorderRadiusSlider extends ConsumerWidget {
  const DefaultBorderRadiusSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double? defaultRadius = ref.watch(Settings.defaultRadiusProvider);
    final bool useSubThemes = ref.watch(Settings.useSubThemesProvider);

    return ListTile(
      title: Slider.adaptive(
        min: -1,
        max: 60,
        divisions: 61,
        label: useSubThemes
            ? defaultRadius == null || defaultRadius < 0
                ? 'default'
                : defaultRadius.toStringAsFixed(0)
            : 'default 4',
        value: useSubThemes ? defaultRadius ?? -1 : -1,
        onChanged: useSubThemes
            ? (double value) {
                ref
                    .read(Settings.defaultRadiusProvider.notifier)
                    .set(value < 0 ? null : value.roundToDouble());
              }
            : null,
      ),
      trailing: Padding(
        padding: const EdgeInsetsDirectional.only(end: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'RADIUS',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              useSubThemes
                  ? defaultRadius == null || defaultRadius < 0
                      ? 'default'
                      : defaultRadius.toStringAsFixed(0)
                  : 'default 4',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
