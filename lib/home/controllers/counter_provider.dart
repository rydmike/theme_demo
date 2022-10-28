import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/counter.dart';

// NotifierProvider used as controller for the counter.
//
// This one is not persisted. We want to get a counter starting from zero
// when we start the app.
final NotifierProvider<Counter, int> counterProvider =
    NotifierProvider<Counter, int>(
  Counter.new,
  name: 'counterProvider',
);
