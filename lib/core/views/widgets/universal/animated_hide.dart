import 'package:flutter/material.dart';

/// This widget is good for using a boolean condition to show/hide the [child]
/// widget. It is a simple convenience wrapper for AnimatedSwitcher
/// where the Widget that is Switched to is an invisible SizedBox.shrink()
/// effectively removing the child by animation in a zero sized widget
/// instead.
class AnimatedHide extends StatelessWidget {
  const AnimatedHide({
    super.key,
    required this.hide,
    this.duration = const Duration(milliseconds: 300),
    required this.child,
  });

  /// Set hide to true to remove the child with size transition.
  final bool hide;

  /// The duration of the hide animation.
  final Duration duration;

  /// The widget to be conditionally hidden, when hide is true.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: child,
        );
      },
      child: hide ? const SizedBox.shrink() : child,
    );
  }
}
