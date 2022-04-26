# A Flutter Theme Demo using FlexColorScheme with Riverpod and StateProvider

This is a simple Flutter demo application that shows one way of using
[FlexColorScheme](https://pub.dev/packages/flex_color_scheme) together with 
[Riverpod](https://pub.dev/packages/flutter_riverpod) to dynamically change 
application theme, using simple **Riverpod** StateProviders for light `theme` and `darkTheme` 
in a [MaterialApp](https://api.flutter.dev/flutter/material/MaterialApp-class.html), 
as well as toggling the [themeMode](https://api.flutter.dev/flutter/material/MaterialApp/themeMode.html) property. 

> ### Riverpod 1.0.0 and FlexColorScheme 5.0.0
> 
> This example has now been updated to be compatible with stable release
> of Riverpod 1.x.x and also to use FlexColorScheme 5.x.x.
> 
> This demo does not yet use new FlexColorScheme V5 features.
> I plan to add V5 features to this demo, and a simple version of how
> to persist the settings with Hive and Riverpod. I also plan to
> add a reference to this repo in the FlexColoScheme v5 docs site so 
> users can find this repo too, since it can be useful as an 
> additional example.

The demo uses several custom [ToggleButtons](https://api.flutter.dev/flutter/material/ToggleButtons-class.html) based Widgets as well as 
Switches and Sliders, to make the UI widgets used to toggle several input values 
for the used and demonstrated FlexColorScheme properties. 

The app demonstrates how the ThemeData, and ThemeMode state of the application can be 
easily managed using Riverpod, together with very simple compound StateProvider's, 
making up the current ThemeData and ThemeMode states. It also shows how simple it 
is to make UI widgets that can be dropped in anywhere were needed in the app 
to manipulate modify the used ThemeData for the application. 

The used approach works regardless of how deep in the widget tree the actual
theme control widgets are in the widget tree. In this example this is demonstrated
by placing some theme widget controls on the classical default Flutter counter page.
The mode toggle is also in the App drawer, and the entire collection of 
demonstrated theming features, and their control widgets are hidden in a bottom sheet.

FlexColorScheme is also used as way to provide many pre-made color scheme together 
with customs color schemes as well and to show other nice automatic and convenient 
theming features it offers, like primary colored surface and background branding.



### Demo

<img src="https://github.com/rydmike/theme_demo/blob/master/resources/theme_demo.gif?raw=true" alt="Theme toggle demo" width="350"/>

