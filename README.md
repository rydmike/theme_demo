# Persisted Flutter Theming using FlexColorScheme and Riverpod

This Flutter application shows how to us [FlexColorScheme](https://pub.dev/packages/flex_color_scheme) together with [Riverpod](https://pub.dev/packages/flutter_riverpod) to dynamically change application theme. It uses **Riverpod** providers for light `theme` and `darkTheme` in a [`MaterialApp`](https://api.flutter.dev/flutter/material/MaterialApp-class.html), and to change used [`themeMode`](https://api.flutter.dev/flutter/material/MaterialApp/themeMode.html). 

## FlexColorScheme 6 and Riverpod 2

This example is designed to work with and use the stable releases of **Riverpod 2** and **FlexColorScheme 6**. It uses many advanced **FlexColorScheme** theming features, but not as many as the [Themes Playground application](https://rydmike.com/flexcolorscheme/themesplayground-v6/#/). It does however use more advanced state management techniques, and it has a nice feature first folder structure. 

This demo is provided as an additional example to the six examples already included with the FlexColorScheme package. This example is also mentioned in the [FlexColorScheme docs](https://docs.flexcolorscheme.com/examples#other-examples). 

| Home screen, part 1 | Homes screen part 2 |
|---------------------|---------------------|
| Add screen shoot 1  | Add screen shoot 2  |

## Features

The demo uses several custom [ToggleButtons](https://api.flutter.dev/flutter/material/ToggleButtons-class.html) based Widgets as well as Switches, Sliders and PopupMenuButtons, to compose UI widgets used to toggle several input values for the used and demonstrated FlexColorScheme features. 

The app demonstrates how the `ThemeData`, and `ThemeMode` state of the application can be easily managed using **Riverpod**, together with `Providers` and `StateNotifierProviders`. That are used to define the current `ThemeData` for light, dark theme and theme mode states. It also shows how simple it is to make small UI theme control widgets that can be dropped in anywhere were needed in an app, and then used to manipulate and modify the `ThemeData` for the application. The UI view widgets modify Riverpod `StateNotifierProviders` that act as theme property controllers in `ThemeData` providers. The `MaterialApp` widget watches these providers and rebuilds whenever a single theming UI widget is changed anywhere in the application.

### The `MaterialApp` 

The use `MaterialApp` setup is very compact. As always separate the dark and light theme into separate `ThemeData` objects, here given by providers that we watch. When you use this setup, the usage of supplied light or dark theme is controlled by the `ThemeMode` enum. We use and watch a third provider for it, so it can easily be toggled via UI.  

```dart
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
```

This approach works regardless of were in the widget tree the actual theme UI widgets are. In this example this is demonstrated by placing all made theme widget controls on the classical default Flutter counter page, yes there is still a counter on the Home page.  Some settings Widgets are also used in an app drawer, and even more can be found in a bottom sheet.

| Screen X           | Screen Y            |
|--------------------|---------------------|
| Add screen shoot   | Add screen shoot    |

## Key-Value database Persistence

Another feature is that this demo persists all theme settings. The implementation used to persist the settings **can be switched dynamically** in the running app between:

1. Memory - volatile, just session based, not really persisted
2. [Shared preferences](https://pub.dev/packages/shared_preferences)
3. [Hive](https://pub.dev/packages/hive)

This example shows how Riverpod can be used to change the used key-value database dependency from inside the Flutter app UI. This may be interesting to study, since this app needs this dependency to be able to read its settings and start. Yet we can control this from inside the running Flutter app. In this case we are using Riverpod as a service locator and dependency injection replacement.

To be able to do this we need to define a `ProviderContainer` in just Dart before we start the Flutter app. So we can access the provider that gives us the currently used key-value DB implementation. We perform whatever async initialization the used key-value DB needs. Before we start the Flutter app we also access a provider that sets upp a listener that will run whenever the key-value DB provider is changed.

Below we also define a `ProviderProviderObserver`, we will use it to print debug logs whenever any provider in this demo app changes.

### Our `main` function


```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// This container can be used to read providers before Flutter app is
  /// initialised with UncontrolledProviderScope, for more info see:
  /// https://github.com/rrousselGit/riverpod/issues/295
  /// https://codewithandrea.com/articles/riverpod-initialize-listener-app-startup/
  final ProviderContainer container = ProviderContainer(
    // This observer is used for logging changes in all providers.
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
```
To provide `keyValueDbProvider` we use a `StateProvider`, typically just a `Provider` would do if we just want to access one predefined concrete implementation. In this case we want to setup a listener that listens to changes in the `keyValueDbProvider` so we can do some async init and data loading work from it, when we change to another implementation dynamically from inside the app.

```dart
/// Provides a [KeyValueDb] DB repository.
///
/// The value returned depends on the controller [usedKeyValueDbProvider].
final StateProvider<KeyValueDb> keyValueDbProvider =
    StateProvider<KeyValueDb>((StateProviderRef<KeyValueDb> ref) {
  return ref.watch(usedKeyValueDbProvider).get;
}, name: 'keyValueDbProvider');
```
The `keyValueDbListenerProvider` above is just a normal `provider`, that we will access to instantiate it and let it it do its work, where we setup the listener.




### Key-Value DB Design Requirements

One of the goals with the design of the key-value persistence model was that each settings value should be saved with its own string `key`. When you change any setting, only the value for this key is persisted. This is done for storage efficiency. 

We could also serialize a big settings class with all the properties to a JSON and save the entire JSON with just one key. Then we would be writing the entire large JSON file to the key-value DB every time a value is changed. This was not desired.

We also did not want to use 

When the app starts, it set the state for each setting by checking if the key exist in the DB, reads it and uses uses hard coded defaults for each setting if  

### Screenshots

<img src="https://github.com/rydmike/theme_demo/blob/master/resources/theme_demo.gif?raw=true" alt="Theme toggle demo" width="350"/>

