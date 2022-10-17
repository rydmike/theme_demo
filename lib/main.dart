import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/views/theme_demo_app.dart';
import 'core/utils/app_provider_observer.dart';
import 'persistence/key_value/key_value_db.dart';
import 'persistence/key_value/used_key_value_db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Select used key-value database implementation. We have three options
  // memory (not persisted), SharedPreferences and Hive.
  //
  // You can change here to try different options, defaults to Hive.

  WidgetsFlutterBinding.ensureInitialized();

  /// this container can be used to read providers before Flutter app is
  /// initialised with UncontrolledProviderScope, for more info see:
  /// https://github.com/rrousselGit/riverpod/issues/295
  /// https://codewithandrea.com/articles/riverpod-initialize-listener-app-startup/
  final ProviderContainer container = ProviderContainer(
    observers: <ProviderObserver>[AppProviderObserver()],
  );
  final UsedKeyValueDb keyDb = container.read(usedKeyValueDbProvider);
  final KeyValueDb keyValueDb = keyDb.get;
  await keyValueDb.init();
  runApp(
    // Wrap the app with a Riverpod ProviderScope, injecting a provider override
    // for our key-value db implementation of choice.
    UncontrolledProviderScope(
      container: container,
      child: ProviderScope(
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
        child: const ThemeDemoApp(),
      ),
    ),
  );
}
