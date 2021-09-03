import 'package:flutter/material.dart';
import 'package:theme_demo/utils/app_insets.dart';

/// A convenience function to show a widget in a customized BottomSheet.
void inBottomSheet(BuildContext context, {required Widget child}) {
  showBottomSheet<void>(
    context: context,
    elevation: AppInsets.bottomSheetElevation,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppInsets.cornerRadius),
        topRight: Radius.circular(AppInsets.cornerRadius),
      ),
    ),
    builder: (BuildContext context) => child,
  );
}
