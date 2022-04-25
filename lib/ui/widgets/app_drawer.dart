import 'package:flutter/material.dart';

import '../../utils/app_const.dart';
import '../../utils/app_icons.dart';
import '../../utils/app_insets.dart';
import '../pages/counter_page.dart';
import '../pages/splash_page.dart';
import '../pages/theme_demo_page.dart';
import 'about.dart';
import 'in_bottom_sheet.dart';
import 'theme/theme_mode_switch.dart';
import 'theme/theme_preferences.dart';

/// An AppDrawer widget used on two pages in this demo application.
///
/// The Drawer shows that for example that our ThemeModeSwitch() widget can
/// just be dropped in the drawer to control theme mode from there as well.
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
          const _Header('Pages'),
          ListTile(
            title: const Text('Counter'),
            trailing: const Icon(AppIcons.menuItemOpen),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.pushReplacementNamed(context, CounterPage.route);
            },
          ),
          ListTile(
            title: const Text('Theme showcase'),
            trailing: const Icon(AppIcons.menuItemOpen),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.pushReplacementNamed(
                  context, ThemeDemoPage.route);
            },
          ),
          // The logout option is only shown if we are logged in.
          const Divider(),
          const _Header('Theme'),
          const ListTile(
            title: Text('Mode'),
            trailing: ThemeModeSwitch(),
          ),
          ListTile(
            title: const Text('Preferences'),
            trailing: const Icon(AppIcons.menuItemOpen),
            onTap: () {
              Navigator.pop(context);
              inBottomSheet(context, child: const ThemePreferences());
            },
          ),
          const Divider(),
          const _Header('General'),
          ListTile(
            title: const Text('Splash'),
            trailing: const Icon(AppIcons.menuItemOpen),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.pushNamed(context, SplashPage.route);
            },
          ),
          ListTile(
            title: const Text('About ${AppConst.appName}'),
            trailing: const Icon(AppIcons.menuItemOpen),
            onTap: () {
              Navigator.pop(context);
              showAppAboutDialog(context);
            },
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppInsets.l,
        AppInsets.s,
        AppInsets.l,
        AppInsets.xs,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
