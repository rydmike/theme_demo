import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateProvider used as controller for the counter.
//
// This one is not persisted. We want to get a counter starting from zero
// when we start the app.
final StateProvider<int> counterProvider = StateProvider<int>(
  (final StateProviderRef<int> ref) => 0,
  name: 'counterProvider',
);
