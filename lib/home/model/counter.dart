import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A Counter model that extends Notifier.
///
/// Instead of using typical [StateProvider] for the counter. We will use
/// the more verbose but more versatile [NotifierProvider].
class Counter extends Notifier<int> {
  /// Initialize the Counter to 0 when it is first built.
  @override
  int build() {
    return 0;
  }

  /// Increment counter value with one
  void increment() {
    state++;
  }
}
