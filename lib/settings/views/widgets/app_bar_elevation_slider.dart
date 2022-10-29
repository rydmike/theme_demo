import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/settings.dart';

class AppBarElevationSlider extends ConsumerWidget {
  const AppBarElevationSlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextStyle style = Theme.of(context).textTheme.bodySmall!;
    final double elevation = ref.watch(Settings.appBarElevationProvider);
    return ListTile(
      title: const Text('AppBar elevation'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Slider.adaptive(
            max: 10,
            divisions: 20,
            label: elevation.toStringAsFixed(1),
            value: elevation,
            onChanged: ref.read(Settings.appBarElevationProvider.notifier).set,
          ),
        ],
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              'Elevation',
              style: style,
            ),
            Text(
              elevation.toStringAsFixed(1),
              style: style.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
