import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/views/theme_demo_app.dart';
import 'core/utils/app_provider_observer.dart';
import 'persistence/key_value/models/key_value_db_listener.dart';
import 'persistence/key_value/models/key_value_db_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// This container can be used to read providers before Flutter app is
  /// initialised with UncontrolledProviderScope, for more info see:
  /// https://github.com/rrousselGit/riverpod/issues/295
  /// https://codewithandrea.com/articles/riverpod-initialize-listener-app-startup/
  final ProviderContainer container = ProviderContainer(
    // This observer is used for logging changes in all Riverpod providers.
    observers: <ProviderObserver>[AppProviderObserver()],
  );

  // Get default keyValueDb implementation and initialize it for use.
  await container.read(keyValueDbProvider).init();
  // The app will also listen to state changes in keyValueDbProvider.
  // This allows us to swap the keyValueDb implementation used in the app
  // dynamically between: Hive, SharedPreferences and volatile memory.
  container.read(keyValueDbListenerProvider);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const ThemeDemoApp(),
    ),
    // ),
  );
}
