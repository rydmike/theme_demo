import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theme_demo/models/providers.dart';
import 'package:theme_demo/ui/widgets/theme_mode_switch.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              'Theme Demo',
              style: Theme.of(context).primaryTextTheme.headline4,
            ),
          ),
          ListTile(
            title: const Text('Mode'),
            trailing:
                Consumer(builder: (BuildContext context, WidgetRef ref, _) {
              return ThemeModeSwitch(
                themeMode: ref.watch(themeModeProvider).state,
                onThemeMode: (ThemeMode newMode) {
                  ref.read(themeModeProvider).state = newMode;
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
