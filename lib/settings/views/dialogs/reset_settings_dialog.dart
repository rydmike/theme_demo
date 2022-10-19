import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../persistence/key_value/controllers/used_key_value_db_provider.dart';

/// Dialog to confirm if user wants to reset the current FlexColorscheme setup.
class ResetSettingsDialog extends ConsumerWidget {
  const ResetSettingsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String usedDb =
        ref.read(usedKeyValueDbProvider.notifier).state.describe;
    return AlertDialog(
      title: Text('Reset $usedDb Theme Settings'),
      content: Text('Reset all $usedDb theme settings back to their '
          'default values?\n'
          'Persisted theme settings will also be updated to default '
          'values.'),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('CANCEL')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('RESET')),
      ],
    );
  }
}
