import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_insets.dart';
import '../../../core/views/widgets/app/color_scheme_box.dart';

// ignore_for_file: comment_references

/// Widget used to select used [FlexSurfaceMode] using [ToggleButtons].
///
/// This is a stateless widget version of surface mode Popupmenu selection using
/// call back. It was designed this way to be state management agnostic.
/// Widget using this widget can use state management to get and set values
/// for this widget. In this app see e.g. widgets
@immutable
class SurfaceModeToggleButtons extends StatelessWidget {
  const SurfaceModeToggleButtons({
    super.key,
    required this.mode,
    this.onChanged,
  });

  final FlexSurfaceMode mode;
  final ValueChanged<FlexSurfaceMode>? onChanged;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final bool showAllModes = media.size.width > AppInsets.phoneWidthBreakpoint;
    final ColorScheme scheme = Theme.of(context).colorScheme;

    final List<bool> isSelected = <bool>[
      mode == FlexSurfaceMode.level,
      mode == FlexSurfaceMode.highBackgroundLowScaffold,
      mode == FlexSurfaceMode.highSurfaceLowScaffold,
      mode == FlexSurfaceMode.highScaffoldLowSurface,
      // Only show this blend option if show all set, not enough room.
      if (showAllModes) mode == FlexSurfaceMode.highScaffoldLevelSurface,
      mode == FlexSurfaceMode.levelSurfacesLowScaffold,
      mode == FlexSurfaceMode.highScaffoldLowSurfaces,
      // Only have these blend options if show all set, not enough room.
      if (showAllModes)
        mode == FlexSurfaceMode.levelSurfacesLowScaffoldVariantDialog,
      if (showAllModes)
        mode == FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
    ];

    // On small media we exclude more exotic options, that will not fit
    // in a toggle buttons presentation.
    final List<FlexSurfaceMode> option = <FlexSurfaceMode>[
      FlexSurfaceMode.level,
      FlexSurfaceMode.highBackgroundLowScaffold,
      FlexSurfaceMode.highSurfaceLowScaffold,
      FlexSurfaceMode.highScaffoldLowSurface,
      // Only have this blend option if show all set, not enough room.
      if (showAllModes) FlexSurfaceMode.highScaffoldLevelSurface,
      FlexSurfaceMode.levelSurfacesLowScaffold,
      FlexSurfaceMode.highScaffoldLowSurfaces,
      // Only have these blend options if show all set, not enough room.
      if (showAllModes) FlexSurfaceMode.levelSurfacesLowScaffoldVariantDialog,
      if (showAllModes) FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        onChanged?.call(option[newIndex]);
      },
      children: _getModeWidget(scheme, showAllModes),
    );
  }
}

/// Widget used to select used [FlexSurfaceMode] using a popup menu.
///
/// This is a stateless widget version of surface mode Popupmenu selection using
/// call back. It was designed this way to be state management agnostic.
/// Widget using this widget can use state management to get and set values
/// for this widget. In this app see e.g. widgets
/// [LightSurfacePopupMenu] and [DarkSurfacePopupMenu].
class SurfaceModePopupMenu extends StatelessWidget {
  const SurfaceModePopupMenu({
    super.key,
    required this.index,
    this.onChanged,
    this.title,
    this.subtitle,
    this.contentPadding,
    this.labelForDefault = 'default (null)',
    this.popupLabelDefault,
  });
  final int index;
  final ValueChanged<int>? onChanged;
  final Widget? title;
  final Widget? subtitle;
  final EdgeInsetsGeometry? contentPadding; // Defaults to 16.
  final String labelForDefault;
  final String? popupLabelDefault;

  // Explain the used surface mode. This is for dev mode to have an explanation
  // of what the used surface mode. All of these are not used by out control,
  // but if we add them this will cover all of them.
  String explainMode(final FlexSurfaceMode mode) {
    switch (mode) {
      case FlexSurfaceMode.level:
        return 'Flat blend\nAll surfaces at blend level 1x\n';
      case FlexSurfaceMode.highBackgroundLowScaffold:
        return 'High background, low scaffold\n'
            'Background 3/2x  Surface 1x  Scaffold 1/2x\n';
      case FlexSurfaceMode.highSurfaceLowScaffold:
        return 'High surface, low scaffold\n'
            'Surface 3/2x  Background 1x  Scaffold 1/2x\n';
      case FlexSurfaceMode.highScaffoldLowSurface:
        return 'High scaffold, low surface\n'
            'Scaffold 3x  Background 1x  Surface 1/2x\n';
      case FlexSurfaceMode.highScaffoldLevelSurface:
        return 'High scaffold, level surface\n'
            'Scaffold 3x  Background 2x  Surface 1x\n';
      case FlexSurfaceMode.levelSurfacesLowScaffold:
        return 'Level surfaces, low scaffold\n'
            'Surface & Background 1x  Scaffold 1/2x\n';
      case FlexSurfaceMode.highScaffoldLowSurfaces:
        return 'High scaffold, low surfaces\n'
            'Scaffold 3x  Surface and Background 1/2x\n';
      case FlexSurfaceMode.levelSurfacesLowScaffoldVariantDialog:
        return 'Tertiary container dialog, low scaffold\n'
            'Surface & Background 1x  Scaffold 1/2x\n'
            'Dialog 1x blend of tertiary container color';
      case FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog:
        return 'High scaffold, tertiary container dialog\n'
            'Scaffold 3x  Surface and Background 1/2x\n'
            'Dialog 1/2x blend of tertiary container color';
      case FlexSurfaceMode.custom:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final TextStyle txtStyle = theme.textTheme.labelLarge!;
    final bool enabled = onChanged != null;
    final String styleName = explainMode(FlexSurfaceMode.values[index]);
    final List<Widget> modeWidgets = _getModeWidget(scheme);

    final IconThemeData selectedIconTheme =
        theme.iconTheme.copyWith(color: scheme.onPrimary.withAlpha(0xE5));
    final IconThemeData unSelectedIconTheme =
        theme.iconTheme.copyWith(color: scheme.primary);

    return PopupMenuButton<int>(
      tooltip: '',
      padding: EdgeInsets.zero,
      onSelected: (int index) {
        // We return -1 for index that reached max length or any negative
        // value will cause controller for a FlexAppBarStyle to be set to
        // "null", we need to be able to do that to input "null" property
        // value to FlexAppBarStyle configs.
        onChanged?.call(index);
      },
      enabled: enabled,
      itemBuilder: (BuildContext context) {
        return <PopupMenuItem<int>>[
          for (int i = 0; i < FlexSurfaceMode.values.length - 1; i++)
            PopupMenuItem<int>(
              value: i,
              child: ListTile(
                dense: true,
                leading: index == i
                    ? IconTheme(
                        data: selectedIconTheme,
                        child: ColorSchemeBox(
                          backgroundColor: scheme.primary,
                          borderColor: scheme.primary,
                          child: modeWidgets[i],
                        ),
                      )
                    : IconTheme(
                        data: unSelectedIconTheme,
                        child: ColorSchemeBox(
                          backgroundColor: Colors.transparent,
                          borderColor: scheme.primary,
                          child: modeWidgets[i],
                        ),
                      ),
                title: Text(
                  _modeShort(FlexSurfaceMode.values[i]),
                  style: txtStyle,
                ),
              ),
            )
        ];
      },
      child: ListTile(
        enabled: enabled,
        contentPadding:
            contentPadding ?? const EdgeInsets.symmetric(horizontal: 16),
        title: title,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (subtitle != null) subtitle!,
            Text(styleName),
          ],
        ),
        trailing: IconTheme(
          data: selectedIconTheme,
          child: ColorSchemeBox(
            backgroundColor: scheme.primary,
            borderColor: scheme.primary,
            child: modeWidgets[index],
          ),
        ),
      ),
    );
  }
}

// A function that returns a List of widgets with the content that we
// need in both the popup menu and toggle buttons implementation.
// It needs the theme ColorScheme so it can't be a const list or final, and
// we need to control when we only included a sub set in toggle buttons case.
List<Widget> _getModeWidget(ColorScheme scheme, [bool allModes = true]) =>
    <Widget>[
      const Tooltip(
        message: 'Flat\nall at same level',
        child: Icon(Icons.check_box_outline_blank),
      ),
      const Tooltip(
        message: 'High background\nlow scaffold',
        child: Icon(Icons.layers_outlined),
      ),
      const Tooltip(
        message: 'High surface\nlow scaffold',
        child: Icon(Icons.layers),
      ),
      Tooltip(
        message: 'High scaffold\nlow surface',
        child: Stack(
          alignment: Alignment.center,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(Icons.layers_outlined),
            ),
            Icon(Icons.layers),
          ],
        ),
      ),
      if (allModes)
        const Tooltip(
          message: 'High scaffold\nlevel surface',
          child: Icon(Icons.dynamic_feed_rounded),
        ),
      const Tooltip(
        message: 'Level surfaces\nlow scaffold',
        child: RotatedBox(quarterTurns: 2, child: Icon(Icons.horizontal_split)),
      ),
      const Tooltip(
        message: 'High scaffold\nlow surfaces',
        child: Icon(Icons.horizontal_split),
      ),
      if (allModes)
        Tooltip(
          message: 'Tertiary container dialog\nlow scaffold',
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              const RotatedBox(
                  quarterTurns: 2, child: Icon(Icons.horizontal_split)),
              Icon(Icons.stop, color: scheme.tertiary, size: 18),
            ],
          ),
        ),
      if (allModes)
        Tooltip(
          message: 'High scaffold\ntertiary container dialog',
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              const Icon(Icons.horizontal_split),
              Icon(Icons.stop, color: scheme.tertiary, size: 18),
            ],
          ),
        ),
    ];

// Short explanation of the used surface mode.
String _modeShort(final FlexSurfaceMode mode) {
  switch (mode) {
    case FlexSurfaceMode.level:
      return 'Flat\nall at same level';
    case FlexSurfaceMode.highBackgroundLowScaffold:
      return 'High background\nlow scaffold';
    case FlexSurfaceMode.highSurfaceLowScaffold:
      return 'High surface\nlow scaffold';
    case FlexSurfaceMode.highScaffoldLowSurface:
      return 'High scaffold\nlow surface';
    case FlexSurfaceMode.highScaffoldLevelSurface:
      return 'High scaffold\nlevel surface';
    case FlexSurfaceMode.levelSurfacesLowScaffold:
      return 'Level surfaces\nlow scaffold';
    case FlexSurfaceMode.highScaffoldLowSurfaces:
      return 'High scaffold\nlow surfaces';
    case FlexSurfaceMode.levelSurfacesLowScaffoldVariantDialog:
      return 'Low scaffold\nTertiaryContainer dialog';
    case FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog:
      return 'High scaffold\ntertiaryContainer dialog';
    case FlexSurfaceMode.custom:
      return '';
  }
}
