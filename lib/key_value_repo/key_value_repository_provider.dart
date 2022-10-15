import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'key_value_repository.dart';

/// A provider for the KeyValueRepository.
///
/// Returns null, we will need to override it with an initialized value before
/// we use it.
final Provider<KeyValueRepository?> keyValueRepositoryProvider =
    Provider<KeyValueRepository?>((ProviderRef<KeyValueRepository?> ref) {
  return null;
});
