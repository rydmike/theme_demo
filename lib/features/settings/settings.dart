import 'package:flutter/foundation.dart';

/// An immutable immutable key-value pair setting and its default value.
@immutable
class Setting<T> {
  const Setting({
    required this.value,
    required this.defaultValue,
    required this.key,
  });

  /// A setting parameter of type T.
  final T value;

  /// The default value for the setting.
  final T defaultValue;

  /// The key used to access the setting in a key-value repository.
  final String key;

  /// Reset to default value.
  Setting<T> get reset => copyWith(value: defaultValue);

  /// Set a new value.
  Setting<T> setValue(T value) => copyWith(value: value);

  // Operator =, trying to be at least
  // Setting<T> operator =(T newValue) => <T>this.copyWith(value: newValue);

  Setting<T> copyWith({
    T? value,
    T? defaultValue,
    String? key,
  }) {
    return Setting<T>(
      value: value ?? this.value,
      defaultValue: defaultValue ?? this.defaultValue,
      key: key ?? this.key,
    );
  }

  @override
  String toString() => 'Setting(value: $value, defaultValue: '
      '$defaultValue, key: $key)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Setting<T> &&
        other.value == value &&
        other.defaultValue == defaultValue &&
        other.key == key;
  }

  @override
  int get hashCode {
    return Object.hash(
      value,
      defaultValue,
      key,
    );
  }
}
