import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/pages/counter_page.dart';
import 'features/pages/theme_demo_page.dart';
import 'features/splash/splash_page.dart';
import 'key_value_repo/key_value_repository.dart';
import 'key_value_repo/key_value_repository_hive.dart';
import 'key_value_repo/key_value_repository_provider.dart';
import 'providers/theme_providers.dart';
import 'utils/app_const.dart';
import 'utils/app_scroll_behavior.dart';

Future<void> main() async {
  final KeyValueRepository keyValueRepository = await keyValueRepositoryInit();

  runApp(
    // Wrap the app with a Riverpod ProviderScope, injecting override for
    // our key-value repository.
    ProviderScope(
      overrides: <Override>[
        keyValueRepositoryProvider.overrideWithProvider(
            Provider<KeyValueRepository>((ProviderRef<KeyValueRepository> ref) {
          ref.onDispose(keyValueRepository.dispose);
          return keyValueRepository;
        }))
      ],
      child: const MyApp(),
    ),
  );
}

// Just as an example that we can put this in separate function and in another
// file with other app init work if needed.
Future<KeyValueRepository> keyValueRepositoryInit() async {
  final KeyValueRepositoryHive kvpDataSource =
      KeyValueRepositoryHive(AppConst.kvpDataSourceName);
  await kvpDataSource.init();
  return kvpDataSource;
}

// We are using a Consumer Widget to access the Riverpod providers we
// use to control the used light and dark themes, as well as mode.
//
// If your app is using a StatefulWidget then you can use StatefulConsumerWidget
// instead, and ConsumerState<T> instead of State<T>.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const AppScrollBehavior(),
      title: AppConst.appName,
      // The light theme depends on lightThemeProvider's state.
      theme: ref.watch(lightThemeProvider),
      // The dark theme depends on darkThemeProvider's state.
      darkTheme: ref.watch(darkThemeProvider),
      // Currently used theme mode depends on themeModeProvider's state.
      themeMode: ref.watch(themeModeProvider),
      // Starting page using named routes.
      initialRoute: CounterPage.route,
      // Named routes and their page builders.
      routes: <String, WidgetBuilder>{
        SplashPage.route: (BuildContext context) => const SplashPage(),
        ThemeDemoPage.route: (BuildContext context) => const ThemeDemoPage(),
        CounterPage.route: (BuildContext context) => const CounterPage(),
      },
    );
  }
}
