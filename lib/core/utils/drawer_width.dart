import 'package:flutter/material.dart';

/// Return a width for a Drawer that is media width responsive.
///
/// Is width responsive as follow:
/// * Is never wider than 360 dp
/// * Leaves empty space of min 56 dp when screen width is larger than 300 dp.
/// * Is never less than 244 dp wide.
/// * Will fill max width if screen is less than 244 dp wide.
double drawerWidth() {
  final double screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;

  /// Drawer, minimum none covered space when screen width is > 300 dp .
  const double minNotUsedSpace = 56; // This is spec in M2.

  /// Minimum width the Drawer theme will ever use.
  ///
  /// If screen is more narrow than this, it will be constrained to screen
  /// width by built in Drawer behavior constraints.
  const double drawerMinWidth = 244;

  /// Max width the Drawer theme will use.
  ///
  /// This is fixed width spec in M3, but it works better if it used as
  /// max width ever used, but only when screen width is wider than
  /// this width plus [minNotUsedSpace].
  const double drawerMaxWidth = 360;

  // Usable Drawer width is total screen width minus minimum not used space.
  final double usableWidth = screenWidth - minNotUsedSpace;

  // Clamp usableWidth between drawerMinWidth and drawerMaxWidth value.
  return usableWidth.clamp(drawerMinWidth, drawerMaxWidth);
}
