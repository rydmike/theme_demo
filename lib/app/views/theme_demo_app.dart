import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_const.dart';
import '../../core/utils/app_scroll_behavior.dart';
import '../../home/views/pages/home_page.dart';
import '../../settings/controllers/settings.dart';
import '../../splash/views/splash_page.dart';
import '../../theme/controllers/theme_providers.dart';
import '../../theme/views/pages/theme_showcase_page.dart';

/// The [MaterialApp] widget for the ThemeDemo application.
///
/// We are using a ConsumerWidget to access the Riverpod providers we
/// use to control the used light and dark themes, as well as mode.
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
      themeMode: ref.watch(Settings.themeModeProvider),
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
