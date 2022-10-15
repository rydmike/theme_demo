import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common_widgets/universal/page_body.dart';
import '../../utils/app_icons.dart';
import '../../utils/app_insets.dart';
import '../drawer/app_drawer.dart';
import '../widgets/about.dart';
import '../widgets/theme/dark_app_bar_style_switch.dart';
import '../widgets/theme/light_app_bar_style_switch.dart';
import '../widgets/theme/show_theme_colors.dart';
import '../widgets/theme/surface_blend_level_slider.dart';
import '../widgets/theme/surface_style_switch.dart';
import '../widgets/theme/theme_mode_switch.dart';
import '../widgets/theme/theme_selector.dart';

/// This is basically the default Flutter counter page, with some theme control
/// widgets on it that use Riverpod state providers internally to also modify
/// active theme.
///
/// NOTE: This local counter state is not kept when switching between pages.
/// As an exercise you can make it to an <int> StateProvider and use it
/// instead, then it will be kept when changing pages too.
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  static const String route = '/counter';

  @override
  State<CounterPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CounterPage> {
  int _counter = 0;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
      keepScrollOffset: true,
      debugLabel: 'pageBodyScroll',
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    final TextTheme textTheme = theme.textTheme;
    final TextStyle headline4 = textTheme.headline4!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ThemeDemo & Counter'),
        actions: const <Widget>[AboutIconButton()],
      ),
      drawer: const AppDrawer(),
      // This annotated region will change the Android system navigation bar to
      // a theme color, matching active theme mode and FlexColorScheme theme.
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: FlexColorScheme.themedSystemNavigationBar(context),
        child: PageBody(
          controller: scrollController,
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(AppInsets.edge),
            children: <Widget>[
              Text('Info', style: headline4),
              const Text(
                'This page shows resulting FlexColorScheme theme based colors '
                'and the other settings. It shows how simple Riverpod based '
                'widgets can be used here, as well as in the Drawer and in a '
                'BottomSheet to control theme settings.',
              ),
              const Divider(),
              const ThemeSelector(
                contentPadding: EdgeInsets.zero,
              ),
              const ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Theme mode'),
                trailing: ThemeModeSwitch(),
              ),
              const Divider(),
              const ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Surface branding'),
                  trailing: SurfaceStyleSwitch()),
              const SurfaceBlendLevelSlider(),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('AppBar style'),
                trailing: isLight
                    ? const LightAppBarStyleSwitch()
                    : const DarkAppBarStyleSwitch(),
              ),
              const Divider(),
              Text('Counter', style: headline4),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'You pushed the (+) button this many times',
                ),
                trailing: Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              const Divider(),
              Text('Theme colors', style: headline4),
              const ShowThemeColors(),
              const Divider(),
              const SizedBox(height: AppInsets.xl),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(AppIcons.add),
      ),
    );
  }
}
