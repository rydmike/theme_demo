import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Riverpod Provider demo to manage application theme changes.
//
// You can put simple providers in same, just one provider per file or
// group them in same files, and put the files where they make sense to you.
//
//

/// Use a state provider to toggle application ThemeMode.
///
/// We could bake this provider into the application theme, but in this app
/// it is kept separate to demonstrate how easy it is to use StateProvider.
final StateProvider<ThemeMode> themeModeProvider =
    StateProvider<ThemeMode>((StateProviderRef<ThemeMode> ref) {
  return ThemeMode.system;
});
