import 'package:flutter/material.dart';

class ThemeModeSwitch extends StatefulWidget {
  const ThemeModeSwitch({
    Key key,
    @required this.themeMode,
    @required this.onThemeMode,
  })  : assert(themeMode != null, 'themeMode cannot be null'),
        assert(onThemeMode != null, 'onThemeMode cannot be null'),
        super(key: key);

  /// The current themeMode option button to be marked as selected.
  final ThemeMode themeMode;

  /// The new theme mode that was selected using the 3 option buttons.
  final ValueChanged<ThemeMode> onThemeMode;

  @override
  _ThemeModeSwitchState createState() => _ThemeModeSwitchState();
}

class _ThemeModeSwitchState extends State<ThemeModeSwitch> {
  @override
  Widget build(BuildContext context) {
    final List<bool> isSelected = [
      widget.themeMode == ThemeMode.light,
      widget.themeMode == ThemeMode.system,
      widget.themeMode == ThemeMode.dark,
    ];
    final colorScheme = Theme.of(context).colorScheme;
    return ToggleButtons(
      isSelected: isSelected,
      selectedColor: colorScheme.surface,
      color: colorScheme.onSurface,
      fillColor: colorScheme.primary,
      borderWidth: 2,
      borderColor: colorScheme.primary,
      selectedBorderColor: colorScheme.primary,
      borderRadius: BorderRadius.circular(50),
      onPressed: (int newIndex) {
        setState(() {
          for (int index = 0; index < isSelected.length; index++) {
            if (index == newIndex) {
              isSelected[index] = true;
            } else {
              isSelected[index] = false;
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
