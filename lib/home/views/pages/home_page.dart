import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../about/views/about.dart';
import '../../../core/constants/app_const.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_insets.dart';
import '../../../core/views/widgets/universal/page_body.dart';
import '../../../drawer/views/app_drawer.dart';
import '../../../persistence/key_value/views/key_value_db_list_tile.dart';
import '../../../settings/controllers/settings.dart';
import '../../../settings/views/dialogs/reset_settings_dialog.dart';
import '../../../theme/views/widgets/show_color_scheme_colors.dart';
import '../../../theme/views/widgets/show_sub_theme_colors.dart';
import '../../../theme/views/widgets/show_theme_data_colors.dart';
import '../../controllers/counter_provider.dart';
import '../../controllers/platform_provider.dart';
import '../widgets/platform_popup_menu.dart';
import '../widgets/theme_settings.dart';

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
    final TextStyle medium = textTheme.headlineMedium!;

    final MediaQueryData media = MediaQuery.of(context);
    final double topPadding = media.padding.top + kToolbarHeight + AppInsets.m;
    final double bottomPadding =
        media.padding.bottom + kBottomNavigationBarHeight;

    final bool isNarrow = media.size.width < AppInsets.phoneWidthBreakpoint;
    final double sideMargin = isNarrow ? 0 : AppInsets.l;

    final int count = ref.watch(counterProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: const Text(AppConst.appName),
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
            padding: EdgeInsets.fromLTRB(
              sideMargin,
              topPadding,
              sideMargin,
              bottomPadding,
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppInsets.l),
                child: Text('Info', style: medium),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppInsets.l),
                child: Text(
                  'FlexColorScheme persisted theme demo. Theme settings '
                  'widgets using Riverpod controllers can be used anywhere in '
                  'the app. On this page, in the Drawer and in a BottomSheet '
                  'to control persisted theme settings.',
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppInsets.l),
                child: Text('Counter', style: medium),
              ),
              ListTile(
                title: Text('You pushed (+) button $count times'),
                subtitle: const Text('Keeping the counter around'),
                trailing: Text('$count', style: medium),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppInsets.l),
                child: Text('Persistence', style: medium),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppInsets.l),
                child: Text(
                  'You can use volatile memory or Shared '
                  'Preferences and Hive to persist the settings. You can '
                  'toggle the used implementation dynamically in the app.',
                ),
              ),
              const KeyValueDbListTile(),
              ListTile(
                title: const Text('Reset settings'),
                onTap: () async {
                  final bool? reset = await showDialog<bool?>(
                    context: context,
                    builder: (BuildContext context) {
                      return const ResetSettingsDialog();
                    },
                  );
                  if (reset ?? false) {
                    Settings.resetAll(ref);
                  }
                },
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppInsets.l),
                child: Text('Theme Settings', style: medium),
              ),
              const ThemeSettings(),
              const Divider(),
              PlatformPopupMenu(
                platform: ref.watch(platformProvider),
                onChanged: (TargetPlatform newPlatform) {
                  ref.read(platformProvider.notifier).state = newPlatform;
                },
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppInsets.edge),
                child: Text('Theme Colors', style: medium),
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
