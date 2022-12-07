import 'package:flutter/material.dart';

/// Icons used in this application.
///
/// Using a class for "feature" based icons used in the application makes
/// it easy to edit them in one place if we want tho change an icons used
/// for feature, and we have central point to maintain our app icons.
class AppIcons {
  // This class is not meant to be instantiated or extended. This constructor
  // prevents external instantiation and extension, plus it does not show up
  // in IDE code completion. We like static classes for constants because it
  // name spaces them and gives them a self documenting group and context that
  // they belong to.
  AppIcons._();
  // The main icons we use
  static const IconData menuItemOpen = Icons.arrow_forward_ios;
  static const IconData add = Icons.add;
  static const IconData info = Icons.info;

  // Theme mode switch icons
  static const IconData lightTheme = Icons.wb_sunny;
  static const IconData systemTheme = Icons.phone_iphone;
  static const IconData darkTheme = Icons.bedtime;
}
