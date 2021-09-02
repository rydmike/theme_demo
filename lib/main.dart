import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theme_demo/models/providers.dart';
import 'package:theme_demo/ui/screens/counter_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const FlexScheme usedFlexScheme = FlexScheme.hippieBlue;
    final ThemeMode themeMode = ref.watch(themeModeProvider).state;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Theme Toggle',

      // The theme for the light theme mode
      theme: FlexColorScheme.light(
        scheme: usedFlexScheme,
        // Strong primary color branded on surface and background, but no
        // branding on scaffoldBackgroundColor.
        surfaceStyle: FlexSurface.strong,
        // AppBar will be background colored with current surfaceStyle applied.
        appBarStyle: FlexAppBarStyle.background,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
      ).toTheme,

      // The theme for the dark theme mode
      darkTheme: FlexColorScheme.dark(
        scheme: usedFlexScheme,
        surfaceStyle: FlexSurface.strong,
        appBarStyle: FlexAppBarStyle.background,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
      ).toTheme,

      // Currently used theme depends on themeMode value.
      themeMode: themeMode,
      home: const CounterPage(title: 'Theme Toggle Demo'),
    );
  }
}
