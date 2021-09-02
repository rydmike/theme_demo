import 'package:flutter/material.dart';

/// ThemeModeSwitch that on purpose only depends on Flutter SDK.
///
/// You could bake in the Riverpod provider as well, but then it is tied
/// to your app and no longer generic. Other switches demonstrate that.
///
/// You can also make this as a Stateless Widget by using an initializer for
/// _isSelected, but then you cannot have a const constructor. It would look
/// like this:
///
/// @immutable
/// class ThemeModeSwitch extends StatelessWidget {
///   ThemeModeSwitch({
///     Key key,
///     @required this.themeMode,
///     @required this.onThemeMode,
///   })  : assert(themeMode != null, 'themeMode cannot be null'),
///         assert(onThemeMode != null, 'onThemeMode cannot be null'),
///         _isSelected = [
///           themeMode == ThemeMode.light,
///           themeMode == ThemeMode.system,
///           themeMode == ThemeMode.dark,
///         ],
///         super(key: key);
///
///  // The current themeMode option button to be marked as selected.
///  final ThemeMode themeMode;
///
///  // The new theme mode that was selected using the 3 option buttons.
///  final ValueChanged<ThemeMode> onThemeMode;
///
///  // Local final set via initializer for the Stateless Widget.
///  final List<bool> _isSelected;
@immutable
class ThemeModeSwitch extends StatefulWidget {
  const ThemeModeSwitch({
    Key? key,
    required this.themeMode,
    required this.onThemeMode,
  }) : super(key: key);

  /// The current themeMode option button to be marked as selected.
  final ThemeMode themeMode;

  /// The new theme mode that was selected using the 3 option buttons.
  final ValueChanged<ThemeMode> onThemeMode;

  @override
  _ThemeModeSwitchState createState() => _ThemeModeSwitchState();
}

class _ThemeModeSwitchState extends State<ThemeModeSwitch> {
  List<bool> _isSelected = <bool>[];

  @override
  void initState() {
    _isSelected = <bool>[
      widget.themeMode == ThemeMode.light,
      widget.themeMode == ThemeMode.system,
      widget.themeMode == ThemeMode.dark,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ToggleButtons(
      isSelected: _isSelected,
      selectedColor: colorScheme.surface,
      color: colorScheme.onSurface,
      fillColor: colorScheme.primary,
      hoverColor: colorScheme.primary.withOpacity(0.2),
      focusColor: colorScheme.primary.withOpacity(0.3),
      borderWidth: 2,
      borderColor: colorScheme.primary,
      selectedBorderColor: colorScheme.primary,
      borderRadius: BorderRadius.circular(50),
      onPressed: (int newIndex) {
        setState(() {
          for (int index = 0; index < _isSelected.length; index++) {
            if (index == newIndex) {
              _isSelected[index] = true;
            } else {
              _isSelected[index] = false;
            }
          }
        });
        // This can be made compacter code wise if you use the enum
        // value order also as mode order for the toggle buttons, but I wanted
        // system mode in the middle in this example.
        if (newIndex == 0) {
          widget.onThemeMode(ThemeMode.light);
        } else if (newIndex == 2) {
          widget.onThemeMode(ThemeMode.dark);
        } else {
          widget.onThemeMode(ThemeMode.system);
        }
      },
      children: const <Widget>[
        Icon(Icons.wb_sunny),
        Icon(Icons.phone_iphone),
        Icon(Icons.bedtime),
      ],
    );
  }
}
