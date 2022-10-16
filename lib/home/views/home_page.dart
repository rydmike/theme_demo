import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../about/views/about.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_insets.dart';
import '../../drawer/views/app_drawer.dart';
import '../../settings/views/widgets/theme_settings.dart';
import '../../theme/views/widgets/show_color_scheme_colors.dart';
import '../../theme/views/widgets/show_theme_data_colors.dart';
import '../../widgets/universal/page_body.dart';
import '../providers/counter_provider.dart';

/// Home page showing with a simple Riverpod count and theme controls.
///
/// Also displays the active
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  static const String route = '/themecounter';

  @override
  ConsumerState<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle headline4 = textTheme.headline4!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ThemeSettings & Counter'),
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
              Text('Counter', style: headline4),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'You pushed the (+) button this many times',
                ),
                trailing: Text(
                  '${ref.watch(counterProvider)}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              const Divider(),
              Text('Theme Settings', style: headline4),
              const ThemeSettings(),
              const Divider(),
              Text('Theme Colors', style: headline4),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppInsets.edge),
                child: ShowThemeDataColors(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppInsets.edge),
                child: ShowColorSchemeColors(),
              ),
              const SizedBox(height: AppInsets.xl),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          ref.read(counterProvider.notifier).update((int state) => state + 1);
        },
        tooltip: 'Increment',
        child: const Icon(AppIcons.add),
      ),
    );
  }
}
