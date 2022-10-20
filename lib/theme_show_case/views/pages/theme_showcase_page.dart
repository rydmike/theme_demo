import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../about/views/about.dart';
import '../../../core/constants/app_insets.dart';
import '../../../core/views/widgets/universal/page_body.dart';
import '../../../drawer/views/app_drawer.dart';
import '../../../theme/views/widgets/show_color_scheme_colors.dart';
import '../../../theme/views/widgets/show_sub_theme_colors.dart';
import '../../../theme/views/widgets/show_theme_data_colors.dart';
import '../../../theme/views/widgets/theme_showcase.dart';

/// This page is used as a demo to show a page using the FlexColorScheme
/// based theme. The widgets and content on it don't really do anything.
class ThemeShowcasePage extends StatefulWidget {
  const ThemeShowcasePage({super.key});

  static const String route = '/themeshowcase';

  @override
  State<ThemeShowcasePage> createState() => _ThemeShowcasePageState();
}

class _ThemeShowcasePageState extends State<ThemeShowcasePage> {
  int _buttonIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle medium = textTheme.headlineMedium!;

    final MediaQueryData media = MediaQuery.of(context);
    final double topPadding = media.padding.top + kToolbarHeight * 2;
    final double bottomPadding =
        media.padding.bottom + kBottomNavigationBarHeight + AppInsets.l;

    final bool isNarrow = media.size.width < AppInsets.phoneWidthBreakpoint;
    final double sideMargin = isNarrow ? 0 : AppInsets.l;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
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
              primary: true,
              padding: EdgeInsets.fromLTRB(
                sideMargin,
                topPadding,
                sideMargin,
                bottomPadding,
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppInsets.l),
                  child: Text('Theme Showcase', style: medium),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppInsets.l),
                  child: Text(
                    'Shows theme colors and the FlexColorScheme based theme '
                    'applied on common widgets. '
                    'It also has a NavigationBar and TabBar in the AppBar, '
                    "to show what they look like, but they don't do anything.",
                  ),
                ),
                const Divider(),
                // Show all key active theme colors.
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Colors', style: medium),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppInsets.edge),
                  child: ShowColorSchemeColors(),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppInsets.edge),
                  child: ShowThemeDataColors(),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppInsets.edge),
                  child: ShowSubThemeColors(),
                ),
                const Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppInsets.edge),
                  child: Text('Showcase', style: medium),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppInsets.edge),
                  child: ThemeShowcase(),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int value) {
            setState(() {
              _buttonIndex = value;
            });
          },
          selectedIndex: _buttonIndex,
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.chat_bubble),
              label: 'Chat',
              tooltip: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.beenhere),
              label: 'Tasks',
              tooltip: '',
            ),
            NavigationDestination(
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
