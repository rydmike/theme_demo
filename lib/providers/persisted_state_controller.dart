import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersistedStateController<T> extends StateController<T> {
  PersistedStateController(super.value);

  @override
  set state(T newState) {
    if (newState != state) super.state = newState;
  }
}
