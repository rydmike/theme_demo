import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'providers.dart';
import 'theme_mode_switch.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    const FlexScheme usedFlexScheme = FlexScheme.hippieBlue;
    final ThemeMode themeMode = watch(themeModeProvider).state;

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
      home: const MyHomePage(title: 'Theme Toggle Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: const DrawerDemo(),
      // This annotated region will change the Android system navigation bar to
      // a theme color matching active theme mode and FlexColorScheme theme.
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: FlexColorScheme.themedSystemNavigationBar(context),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              Consumer(builder: (context, watch, _) {
                return ThemeModeSwitch(
                  themeMode: watch(themeModeProvider).state,
                  onThemeMode: (ThemeMode newMode) {
                    context.read(themeModeProvider).state = newMode;
                  },
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DrawerDemo extends StatelessWidget {
  const DrawerDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              'Theme toggle',
              style: Theme.of(context).primaryTextTheme.headline4,
            ),
          ),
          ListTile(
            title: const Text('Theme'),
            trailing: Consumer(builder: (context, watch, _) {
              return ThemeModeSwitch(
                themeMode: watch(themeModeProvider).state,
                onThemeMode: (ThemeMode newMode) {
                  context.read(themeModeProvider).state = newMode;
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
