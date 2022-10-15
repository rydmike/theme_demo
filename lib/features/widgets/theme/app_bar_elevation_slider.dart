import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/theme_providers.dart';

class AppBarElevationSlider extends ConsumerWidget {
  const AppBarElevationSlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double elevation = ref.watch(appBarElevationProvider);
    final TextTheme textTheme = Theme.of(context).textTheme;
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
              onChanged: (double value) {
                ref.read(appBarElevationProvider.state).state = value;
              }),
        ],
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            // Text(
            //   'Elevation',
            //   style: textTheme.caption,
            // ),
            Text(
              elevation.toStringAsFixed(1),
              style: textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
