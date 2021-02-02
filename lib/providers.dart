import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Using a state provider to toggle application ThemeMode
final StateProvider<ThemeMode> themeModeProvider =
    StateProvider<ThemeMode>((ProviderReference ref) {
  return ThemeMode.system;
});
