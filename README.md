# Persisted Flutter Theming using FlexColorScheme and Riverpod

This Flutter demo application shows one way of using
[FlexColorScheme](https://pub.dev/packages/flex_color_scheme) together with 
[Riverpod](https://pub.dev/packages/flutter_riverpod) to dynamically change 
application theme. It uses  **Riverpod** providers for light `theme` and `darkTheme` 
in a [MaterialApp](https://api.flutter.dev/flutter/material/MaterialApp-class.html), 
as well as to toggling the [themeMode](https://api.flutter.dev/flutter/material/MaterialApp/themeMode.html) property. 

## Riverpod 2 and FlexColorScheme 6

This example has now been updated to be compatible with and use the stable releases
of **Riverpod 2.x.x** and **FlexColorScheme 6.x.x.**

This demo uses many FlexColorScheme V5 and V6 theming features, but not as many as the [Themes Playground application](https://rydmike.com/flexcolorscheme/themesplayground-v6/#/). It does however use other more advanced techniques, and is provided as an additional example to the six ones provided with the FlexColorScheme package. This example is also mentioned in the [FlexColorScheme docs](https://docs.flexcolorscheme.com/examples#other-examples) 

## Features

The demo uses several custom [ToggleButtons](https://api.flutter.dev/flutter/material/ToggleButtons-class.html) based Widgets as well as Switches, Sliders and PopupMenuButtons, to compose UI widgets used to toggle several input values 
for the used and demonstrated FlexColorScheme properties. 

The app demonstrates how the ThemeData, and ThemeMode state of the application can be 
easily managed using Riverpod, together with StateNotifierProviders, making up the current ThemeData and ThemeMode states. It also shows how simple it is to make UI widgets that can be dropped in anywhere were needed in the app to manipulate modify the used ThemeData for the application. 

The used approach works regardless of how deep in the widget tree the actual theme control widgets are in the widget tree. In this example this is demonstrated by placing all theme widget controls on the classical default Flutter counter page, yes there is still a counter on the Home page.

Some settings Widget are also used in the App drawer, and even more can be found in a bottom sheet.

## Key-Value database Persistence

Another feature is that this demo persists all theme settings. The implementation used to persist the settings **can be switched dynamically in the app UI** between:

1. Memory - volatile, just session based, not really persisted.
2. [Shared preferences](https://pub.dev/packages/shared_preferences)
3. [Hive](https://pub.dev/packages/hive)


This example show how Riverpod can be used to change the used key-value database dependency, form inside Flutter app UI. This may be interesting to study, since this Flutter app needs this dependency to be able to read its settings and start.

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

### Key-Value DB Design Requirements

One of the goals with the design of the key-value persistence model was that each settings value should be saved with its own string `key`. When you change any setting, only the value for this key is persisted. This is done for storage efficiency. 

We could also serialize a big settings class with all the properties to a JSON and save the entire JSON with just one key. Then we would be writing the entire large JSON file to the key-value DB every time a value is changed. This was not desired.

We also did not want to use 

When the app starts, it set the state for each setting by checking if the key exist in the DB, reads it and uses uses hard coded defaults for each setting if  

### Screenshots

<img src="https://github.com/rydmike/theme_demo/blob/master/resources/theme_demo.gif?raw=true" alt="Theme toggle demo" width="350"/>

