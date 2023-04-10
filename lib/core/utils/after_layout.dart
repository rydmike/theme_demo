import 'dart:async';

import 'package:flutter/widgets.dart';

// ignore_for_file: discarded_futures

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then(
      (_) {
        if (mounted) afterLayout(context);
      },
    );
  }

  FutureOr<void> afterLayout(BuildContext context);
}
