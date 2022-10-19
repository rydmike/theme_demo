import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/used_key_value_db_provider.dart';
import '../models/used_key_value_db.dart';
import 'key_value_db_toggle_buttons.dart';

class ThemeModeListTile extends ConsumerWidget {
  const ThemeModeListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String usedDb =
        ref.watch(usedKeyValueDbProvider.notifier).state.describe;
    return ListTile(
      title: Text('Used key value database - $usedDb'),
      subtitle: const Text('You can change used persistence implementation '
          'dynamically in the app. Mem is ram and not persisted.'),
      onTap: () {
        switch (ref.read(usedKeyValueDbProvider.notifier).state) {
          case UsedKeyValueDb.memory:
            ref.read(usedKeyValueDbProvider.notifier).state =
                UsedKeyValueDb.sharedPreferences;
            break;
          case UsedKeyValueDb.sharedPreferences:
            ref.read(usedKeyValueDbProvider.notifier).state =
                UsedKeyValueDb.hive;
            break;
          case UsedKeyValueDb.hive:
            ref.read(usedKeyValueDbProvider.notifier).state =
                UsedKeyValueDb.memory;
            break;
        }
      },
      trailing: const KeyValueDbToggleButtons(),
    );
  }
}
