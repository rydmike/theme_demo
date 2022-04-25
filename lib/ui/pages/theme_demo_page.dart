import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/app_insets.dart';
import '../widgets/about.dart';
import '../widgets/app_drawer.dart';
import '../widgets/page_body.dart';
import '../widgets/theme/show_theme_colors.dart';
import '../widgets/theme/theme_showcase.dart';

/// This page is used as a demo to show a page using the FlexColorScheme
/// based theme. The widgets and content on it don't really do anything.
class ThemeDemoPage extends StatefulWidget {
  const ThemeDemoPage({Key? key}) : super(key: key);

  static const String route = '/themedemo';

  @override
  _ThemeDemoPageState createState() => _ThemeDemoPageState();
}

class _ThemeDemoPageState extends State<ThemeDemoPage> {
  int _buttonIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle headline4 = textTheme.headline4!;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Theme Showcase'),
          actions: const <Widget>[AboutIconButton()],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: 'Home'),
              Tab(text: 'Favorites'),
              Tab(text: 'Profile'),
              Tab(text: 'Settings'),
            ],
          ),
        ),
        drawer: const AppDrawer(),
        // This annotated region will change the Android system navigation bar
        // to a theme color matching active FlexColorScheme theme.
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: FlexColorScheme.themedSystemNavigationBar(context),
          child: PageBody(
            child: ListView(
              padding: const EdgeInsets.all(AppInsets.edge),
              children: <Widget>[
                Text('Theme demo', style: headline4),
                const Text(
                  'This page shows resulting theme colors and the '
                  'FlexColorScheme based theme applied on common widgets. '
                  'It also has a BottomNavigationBar and TabBar in the AppBar, '
                  "to show what they look like, but they don't do anything.",
                ),
                const Divider(),
                // Show all key active theme colors.
                Text('Theme colors', style: headline4),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppInsets.edge),
                  child: ShowThemeColors(),
                ),
                const Divider(),
                Text('Theme Showcase', style: headline4),
                const ThemeShowcase(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int value) {
            setState(() {
              _buttonIndex = value;
            });
          },
          currentIndex: _buttonIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: 'Chat',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.beenhere),
              label: 'Tasks',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.create_new_folder),
              label: 'Archive',
              tooltip: '',
            ),
          ],
        ),
      ),
    );
  }
}
