# Persisted Flutter Theming using FlexColorScheme and Riverpod

This Flutter application shows how to use [FlexColorScheme](https://pub.dev/packages/flex_color_scheme) together with [Riverpod](https://pub.dev/packages/flutter_riverpod) to dynamically change your application theme. It uses **Riverpod** providers tp watch light `theme` and `darkTheme` in a [`MaterialApp`](https://api.flutter.dev/flutter/material/MaterialApp-class.html), and to change used [`themeMode`](https://api.flutter.dev/flutter/material/MaterialApp/themeMode.html).

This app is used to demonstrate the concepts and ideas, not as much to look pretty or be very useful. 

## FlexColorScheme 6 and Riverpod 2

This example is designed to work with and use the stable releases of **FlexColorScheme 6** and **Riverpod 2**. It uses many advanced **FlexColorScheme** theming features, but not as many as the [Themes Playground application](https://rydmike.com/flexcolorscheme/themesplayground-v6/#/). It does however use more advanced state management techniques than the Themes Playground app, and it has a simple feature-first folder structure, making it easy to find related code by feature. 

This demo is provided as an additional example to the six examples already included with the FlexColorScheme package. It is also mentioned in the [FlexColorScheme docs](https://docs.flexcolorscheme.com/examples#other-examples). 

| Home screen, part 1 | Homes screen part 2 |
|---------------------|---------------------|
| Add screen shoot 1  | Add screen shoot 2  |

## Features

The demo uses several custom [ToggleButtons](https://api.flutter.dev/flutter/material/ToggleButtons-class.html) based Widgets as well as Switches, Sliders and PopupMenuButtons, to compose UI widgets used to toggle several input values for the used and demonstrated FlexColorScheme features. 

The app demonstrates how the `ThemeData`, and `ThemeMode` state of the application can be easily managed using **Riverpod**, together with `Providers` and `StateNotifierProviders`. That are used to define the current `ThemeData` for light, dark theme and theme mode states. 

It also shows how simple it is to make small UI theme control widgets that can be dropped in anywhere were needed in an app, and then used to manipulate and modify the `ThemeData` for the application. The UI view widgets modify Riverpod `StateNotifierProviders` that act as theme property controllers in `ThemeData` providers. The `MaterialApp` widget watches these providers and rebuilds whenever a single theming UI widget is changed anywhere in the application.

### The `MaterialApp` 

The `MaterialApp` setup is very simple and compact. We give the light and dark `ThemeData` objects to their respective theme properties in the `MaterialApp`. Here they are given by providers that we watch for changes. When you use this setup, which one of the currently supplied light and dark theme is controlled by the `ThemeMode` enum given to the `themeMode` property. We use and watch a third provider for this, so theme mode can easily be toggled via UI. 

If you specify `ThemeMode.system` the application will follow the theme mode used by the host system. Many users like this option, so don't just offer light and dark, also offer system as a user choice. A very handy widget to use to allow the user to toggle `ThemeMode` between, light, dark and system is `ToggleButtons`. We will look at that later.  

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
        ThemeShowcasePage.route: (BuildContext context) => const ThemeShowcasePage(),
        HomePage.route: (BuildContext context) => const HomePage(),
      },
    );
  }
}
```

This approach works regardless of were in the widget tree the actual theme UI controlling widgets are. In this example this is demonstrated by placing all made theme widget controls on the classical default Flutter counter page, yes there is still a counter on the Home page. Some theme settings Widgets are also used in the application drawer, and even more can be found in a bottom sheet.

| Screen X           | Screen Y            |
|--------------------|---------------------|
| Add screen shoot   | Add screen shoot    |

## Dynamic Key-Value Database Switching

Another feature is that this demo persists all theme settings. The implementation used to persist the settings **can be switched dynamically** in the running app between:

1. Memory - volatile, just session based, not persisted
2. [Shared preferences](https://pub.dev/packages/shared_preferences)
3. [Hive](https://pub.dev/packages/hive)

This example shows how Riverpod can be used to change the used key-value database dependency from inside the Flutter app UI. This may be interesting to study, since this app needs this dependency to be able to read its settings and start. Yet we can control this from inside the running Flutter app. In this case we are using Riverpod as a service locator and dependency injection replacement.

Is it really necessary to switch a key-value DB persistence implementation at runtime? Well maybe not, but the principle might be useful as an in-app development toggle during development and testing for other data sources, like a remote and mock off-line data source. It can be useful to have a setup that allows you to do it in-app from developer options. Plus I wanted to see if it can be done with just Riverpod, before I would have done this part with [GetIt](https://pub.dev/packages/get_it). 

To be able to do this with only **Riverpod** we need to define a `ProviderContainer` in just plain Dart before we start the Flutter app. We can then access the provider that gives us the currently used key-value DB implementation. We can then perform whatever async initialization the used key-value DB needs. 

Before we start the Flutter app, we also access a provider that sets upp a listener that will run whenever the key-value DB provider is changed.

Below we also define a `AppProviderObserver` as a `ProviderObserver`, we use it to print debug logs whenever any provider in this app changes.

### Our `main` Function

The setup of above feature are done in the `main` function and looks as follows.

```dart
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
```

### Providers in `main`

To provide `keyValueDbProvider` we use a `StateProvider`, typically just a `Provider` would do if we just want to access one predefined concrete implementation. In this case we want to define a listener that listens to changes in the `keyValueDbProvider` so we can do some async init and data loading work, when we change to another implementation dynamically from inside the app.

```dart
/// Provides a [KeyValueDb] DB repository.
///
/// The value returned depends on the controller [usedKeyValueDbProvider].
final StateProvider<KeyValueDb> keyValueDbProvider =
StateProvider<KeyValueDb>((StateProviderRef<KeyValueDb> ref) {
  ref.onDispose(
        () {
      if (_debug) debugPrint('keyValueDbProvider: onDispose called');
    },
  );
  return ref.watch(usedKeyValueDbProvider).get;
}, name: 'keyValueDbProvider');
```

I also like to give Riverpod providers names in its `name`, they are useful for debug purposes. For example in the `AppProviderObserver` we can use it to print the name of the provider that was changed.

The `keyValueDbListenerProvider` above in `main` is just a normal `provider`, that we use to access `KeyValueDbListener`.

```dart
/// A provider used to read and activate a [KeyValueDbListener].
final Provider<KeyValueDbListener> keyValueDbListenerProvider =
Provider<KeyValueDbListener>((ProviderRef<KeyValueDbListener> ref) {
  if (_debug) debugPrint('keyValueDbListenerProvider called');
  return KeyValueDbListener(ref);
});
```

### Listener `KeyValueDbListener` Callback When Key-Value DB is Changed

The act of reading the `container.read(keyValueDbListenerProvider)`, will instantiate the `KeyValueDbListener`. In it, we will define a listener that allows us to listen for changes to the `keyValueDbProvider` and run a call-back that does the async work of initializing the new `KeyValueDb` we switched to.

```dart
/// A listener that listens to changes in the [keyValueDbProvider].
///
/// When the [keyValueDbProvider] state changes, we initialize the
/// new provided DB and read all its DB values and updates UI settings
/// controls to the values from the new [KeyValueDb] implementation.
class KeyValueDbListener {
  // Pass a Ref argument to the constructor
  KeyValueDbListener(this.ref) {
    if (_debug) debugPrint('KeyValueDbListener: new instance');
    // Call _init as soon as the object is created
    _init();
  }
  final Ref ref;

  void _init() {
    if (_debug) debugPrint('KeyValueDbListener: _init() setup listen');
    // Listen to state changes in keyValueDbProvider.state.
    ref.listen<StateController<KeyValueDb>>(keyValueDbProvider.state,
            (StateController<KeyValueDb>? previous,
            StateController<KeyValueDb> current) async {
          final KeyValueDb keyValueDb = current.state;
          // This callback executes when the keyValueDbProvider value changes.
          if (_debug) {
            debugPrint('KeyValueDbListener: listen called - - - - -');
            debugPrint('  DB switch : ${current.state}');
          }
          await keyValueDb.init();
          // We changed key valued DB, we must update all settings controls.
          Settings.getAll(ref);
        });
  }
}
``` 

This approach is very similar to the one described by [Andrea Bizzotto](https://github.com/bizz84/) in his article ["Flutter Riverpod: How to Register a Listener during App Startup"](https://codewithandrea.com/articles/riverpod-initialize-listener-app-startup/). In this solution we do not need streams, since we are only listening to a change in a UI control used to select the used key-value DB implementation.

### State Controller `usedKeyValueDbProvider` Used by UI to Change Key-Value DB

The last part is that above in the `keyValueDbProvider` we watch `usedKeyValueDbProvider` and used the getter `get` in `ref.watch(usedKeyValueDbProvider).get` to get the user selected key-value DB implementation. 

The `usedKeyValueDbProvider` is a simple `StateProvider` that holds an `enum` value called `UsedKeyValueDb`. We can use this `usedKeyValueDbProvider` and change its state value with for example a `ToggleButtons` UI widget. 

```dart
/// A [StateProvider] controller used to control which [KeyValueDb]
/// implementation is used.
///
/// Used by UI widgets to select used [KeyValueDb] implementation.
final StateProvider<UsedKeyValueDb> usedKeyValueDbProvider =
StateProvider<UsedKeyValueDb>(
      (final StateProviderRef<UsedKeyValueDb> ref) => AppDb.keyValue,
  name: 'usedKeyValueDbProvider',
);
```

### Enhanced enum `UsedKeyValueDb`

The `UsedKeyValueDb` is also an [enhanced enum](https://dart.dev/guides/language/language-tour#declaring-enhanced-enums) and its getter, `get` can be used to return the corresponding key-value DB implementation.

```dart
/// An enhanced enum used to represent, select and describe the used 
/// [KeyValueDb] implementation.
enum UsedKeyValueDb {
  memory(),
  sharedPreferences(),
  hive(AppDb.keyValueFilename); // Used filename for the Hive storage box.

  final String _filename;
  const UsedKeyValueDb([this._filename = '']);

  /// Get the [KeyValueDb] implementation corresponding to the enum value.
  KeyValueDb get get {
    switch (this) {
      case UsedKeyValueDb.memory:
        return KeyValueDbMem();
      case UsedKeyValueDb.sharedPreferences:
        return KeyValueDbPrefs();
      case UsedKeyValueDb.hive:
        return KeyValueDbHive(_filename);
    }
  }

  /// Describe the [KeyValueDb] implementation corresponding to the enum value.
  String get describe {
    switch (this) {
      case UsedKeyValueDb.memory:
        return 'Memory';
      case UsedKeyValueDb.sharedPreferences:
        return 'Shared Preferences';
      case UsedKeyValueDb.hive:
        return 'Hive';
    }
  }
}
```

That's it for being able to switch in different key-value DB implementation using only **Riverpod**. Perhaps there is a better way, but this worked and that was the aim of the demo. How useful this is depends



### Key-Value DB Design Requirements

One of the goals with the design of the key-value persistence model was that each settings value should be saved with its own string `key`. When you change any setting, only the value for this key is persisted. This is done for storage efficiency. 

We could also serialize a big settings class with all the properties to a JSON and save the entire JSON with just one key. Then we would be writing the entire large JSON file to the key-value DB every time a value is changed. This was not desired.

We also did not want to use 

When the app starts, it set the state for each setting by checking if the key exist in the DB, reads it and uses hard coded defaults for each setting if  

### Screenshots

<img src="https://github.com/rydmike/theme_demo/blob/master/resources/theme_demo.gif?raw=true" alt="Theme toggle demo" width="350"/>

