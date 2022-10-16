import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_const.dart';
import '../../home/views/home_page.dart';
import '../../splash/views/splash_page.dart';
import '../../theme/providers/theme_providers.dart';
import '../../theme/views/pages/theme_showcase_page.dart';
import '../../utils/app_scroll_behavior.dart';

// We are using a Consumer Widget to access the Riverpod providers we
// use to control the used light and dark themes, as well as mode.
//
// If your app is using a StatefulWidget then you can use StatefulConsumerWidget
// instead, and ConsumerState<T> instead of State<T>.
class ThemeDemoApp extends ConsumerWidget {
  const ThemeDemoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const AppScrollBehavior(),
      title: AppConst.appName,
      theme: ref.watch(lightThemeProvider),
      darkTheme: ref.watch(darkThemeProvider),
      themeMode: ref.watch(themeModeProvider),
      initialRoute: HomePage.route,
      routes: <String, WidgetBuilder>{
        SplashPage.route: (BuildContext context) => const SplashPage(),
        ThemeShowcasePage.route: (BuildContext context) =>
            const ThemeShowcasePage(),
        HomePage.route: (BuildContext context) => const HomePage(),
      },
    );
  }
}
