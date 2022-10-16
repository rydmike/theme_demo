import 'package:flutter/material.dart';

import '../../about/views/about.dart';
import '../../bottomsheet/views/bottom_sheet_settings.dart';
import '../../bottomsheet/views/in_bottom_sheet.dart';
import '../../constants/app_const.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_insets.dart';
import '../../home/views/home_page.dart';
import '../../settings/views/widgets/theme_mode_toggle_buttons.dart';
import '../../splash/views/splash_page.dart';
import '../../theme/views/pages/theme_showcase_page.dart';

/// An AppDrawer widget used on two pages in this demo application.
///
/// The Drawer shows that for example that our ThemeModeSwitch() widget can
/// just be dropped in the drawer to control theme mode from there as well.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: <Color>[
                  theme.colorScheme.primary,
                  theme.primaryColorLight,
                ],
              ),
            ),
            child: Text(
              'Theme Demo',
              style: Theme.of(context).primaryTextTheme.headline4,
            ),
          ),
          const _Header('Pages'),
          ListTile(
            title: const Text('Home'),
            trailing: const Icon(AppIcons.menuItemOpen),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.pushReplacementNamed(context, HomePage.route);
            },
          ),
          ListTile(
            title: const Text('Theme showcase'),
            trailing: const Icon(AppIcons.menuItemOpen),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.pushReplacementNamed(
                  context, ThemeShowcasePage.route);
            },
          ),
          // The logout option is only shown if we are logged in.
          const Divider(),
          const _Header('Theme'),
          const ListTile(
            title: Text('Mode'),
            trailing: ThemeModeToggleButtons(),
          ),
          ListTile(
            title: const Text('Bottom sheet'),
            trailing: const Icon(AppIcons.menuItemOpen),
            onTap: () {
              Navigator.pop(context);
              inBottomSheet(context, child: const BottomSheetSettings());
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
  const _Header(this.title);

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
