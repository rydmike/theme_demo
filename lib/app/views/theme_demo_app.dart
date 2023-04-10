import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_const.dart';
import '../../core/utils/app_scroll_behavior.dart';
import '../../core/utils/drawer_width.dart';
import '../../home/controllers/drawer_width_provider.dart';
import '../../home/views/pages/home_page.dart';
import '../../settings/controllers/settings.dart';
import '../../splash/views/splash_page.dart';
import '../../theme/controllers/theme_providers.dart';
import '../../theme_showcase/views/pages/theme_showcase_page.dart';

// ignore_for_file: prefer_mixin

/// The [MaterialApp] widget for the ThemeDemo application.
///
/// We use a ConsumerStatefulWidget to access the Riverpod providers we
/// use to control the used light and dark themes, as well as theme mode.
///
/// We use stateful version to be able to update the Drawer width provider used
/// in the app theme when media width changes on window resize. We do this
/// before we have a MediaQuery in the context. This may be a bit overkill,
/// but is used here to demonstrate how we can make a media size dependent
/// Drawer width theme, even if Flutter framework does not support media size
/// dependent theme out-of-the box as theme property for the Drawer.
class ThemeDemoApp extends ConsumerStatefulWidget {
  const ThemeDemoApp({super.key});

  @override
  ConsumerState<ThemeDemoApp> createState() => _ThemeDemoAppState();
}

class _ThemeDemoAppState extends ConsumerState<ThemeDemoApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    ref.read(drawerWidthProvider.notifier).state = drawerWidth();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Rebuild MaterialApp');

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
