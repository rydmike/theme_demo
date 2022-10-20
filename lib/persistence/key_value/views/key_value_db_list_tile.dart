import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/used_key_value_db_provider.dart';
import '../models/used_key_value_db.dart';
import 'key_value_db_toggle_buttons.dart';

class KeyValueDbListTile extends ConsumerWidget {
  const KeyValueDbListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String usedDb = ref.watch(usedKeyValueDbProvider).describe;
    return ListTile(
      title: const Text('Storage'),
      subtitle: Text(usedDb),
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
