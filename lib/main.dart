import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/providers/app_provider_observer.dart';
import 'app/views/theme_demo_app.dart';
import 'persistence/key_value/key_value_db.dart';
import 'persistence/key_value/used_key_value_db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Select used key-value database implementation. We have three options
  // memory (not persisted), SharedPreferences and Hive.
  //
  // You can change here to try different options, defaults to Hive.
  final KeyValueDb keyValueDb = await usedKeyValueDb(UsedKeyValueDb.hive);

  runApp(
    // Wrap the app with a Riverpod ProviderScope, injecting an override for
    // our key-value db implementation of choice.
    ProviderScope(
      overrides: <Override>[
        keyValueDbProvider.overrideWithProvider(
          Provider<KeyValueDb>(
            (ProviderRef<KeyValueDb> ref) {
              ref.onDispose(keyValueDb.dispose);
              return keyValueDb;
            },
          ),
        ),
      ],
      observers: <ProviderObserver>[AppProviderObserver()],
      child: const ThemeDemoApp(),
    ),
  );
}
