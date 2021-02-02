# Simple Flutter Theme Toggle with ToggleButtons, Riverpod and StateProvider

This is a simple Flutter demo application that shows how to use 
[**Riverpod**](https://pub.dev/packages/flutter_riverpod) and [**ToggleButtons**](https://api.flutter.dev/flutter/material/ToggleButtons-class.html) to change between using a provided light and dark theme in a Flutter
[**MaterialApp**](https://api.flutter.dev/flutter/material/MaterialApp-class.html) using the
[**themeMode**](https://api.flutter.dev/flutter/material/MaterialApp/themeMode.html) property. 

The demo is using a small custom ToggleButtons based Widget, here called ThemeModeSwitch, to make the UI toggle that 
changes the theme mode.

This example ThemeModeSwitch toggle widget depends only on Flutter SDK and is not dependent on any state management 
solution. This tri-state custom ToggleButtons widget also offers using ThemeMode.system to allow the device to 
control the used theme mode, or user can select light or dark mode independently of the theme mode of the device.

The app also demonstrates how the theme mode state of the application can be managed with Riverpod, and a 
StateProvider holding the current ThemeMode state, and how the ThemeModeSwitch can be used to change this state
and via that the active theme mode of the application.

The used approach works regardless of how deep in the widget tree the actual ThemeModeSwitch toggle widget 
is in the tree. Here it just happens to be on the home page. To show that it also works when used elsewhere, 
the theme toggle widget is also made available in a drawer menu.

For simplicity and familiarity all functionality and features were just been added the Flutter default counter app.

The demo application is also using [**FlexColorScheme**](https://pub.dev/packages/flex_color_scheme) for the used 
light and dark themes in the demo, but that could be any light and dark theme as well. When used on a device the
FlexColorScheme does however also in this example correctly theme the Android system navigation bar to a matching 
theme color and theme mode as the mode is changed.

FlexColorScheme also offers 28 different light/dark color scheme pairs out of the box, that you use by 
simply changing the used `usedFlexScheme` constant: 

```dart
const FlexScheme usedFlexScheme = FlexScheme.hippieBlue;
```

to any of the [**enum values**](https://pub.dev/packages/flex_color_scheme#appendix-a---built-in-scheme-reference) 
provided by FlexColorScheme.

### Demo

<img src="https://github.com/rydmike/theme_demo/blob/master/resources/theme_toggle_demo.gif?raw=true" alt="Theme toggle demo"/>

