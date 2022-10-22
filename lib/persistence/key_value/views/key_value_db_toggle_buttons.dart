import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/used_key_value_db_provider.dart';
import '../models/used_key_value_db.dart';
// ignore_for_file: comment_references

/// UI to toggle the used [KeyValueDb] implementation of the application.
///
/// This [ToggleButtons] UI control bakes in a Riverpod [StateProvider] and is
/// tied to this app
/// implementation. This approach is easy to use since there is nothing to
/// pass around to set its value, just drop in the const Widget anywhere in
/// the app abd use the UI control
@immutable
class KeyValueDbToggleButtons extends ConsumerWidget {
  const KeyValueDbToggleButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UsedKeyValueDb keyValueDb = ref.watch(usedKeyValueDbProvider);
    final List<bool> isSelected = <bool>[
      keyValueDb == UsedKeyValueDb.memory,
      keyValueDb == UsedKeyValueDb.sharedPreferences,
      keyValueDb == UsedKeyValueDb.hive,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        ref.read(usedKeyValueDbProvider.notifier).state =
            UsedKeyValueDb.values[newIndex];
      },
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('Mem'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('Prefs'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('Hive'),
        ),
      ],
    );
  }
}
