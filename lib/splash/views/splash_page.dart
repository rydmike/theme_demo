import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/universal/colored_text.dart';

/// SplashPageOne splash example page.
class SplashPage extends StatelessWidget {
  /// Default const constructor.
  const SplashPage({super.key});

  static const String route = '/splash';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;

    // This splash page sets scaffold background to white in light theme and
    // to black in dark mode AND does the same via the annotated region for
    // the system navigation bar, make it match the color.
    // It also set noAppBar to true, making its scrim transparent in Android.
    // This setup should only be used when the Scaffold has no app bar, like
    // here.
    // When invertStatusIcons is set to true it inverts the colors of the
    // status bar icons making them invisible, BUT only if the background
    // is white in light theme mode and black in dark theme mode, both are
    // usable for splash and onboarding flows.
    //
    // This setup is an alternative way to produce a fairly clean splash page.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavigationBarColor: isLight ? Colors.white : Colors.black,
        noAppBar: true,
        invertStatusIcons: true,
      ),
      child: Scaffold(
        backgroundColor: isLight ? Colors.white : Colors.black,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ColoredText(
                  'Splash!',
                  style: theme.textTheme.headline2,
                ),
                const SizedBox(height: 20),
                const Text('A clean splash screen'),
                const SizedBox(height: 8),
                const Text('No status bar scrim and has inverted status icons',
                    textAlign: TextAlign.center),
                const SizedBox(height: 8),
                const ColoredText('I am ColoredText, primary by default'),
                const ColoredText(
                  'I can be bold easily',
                  fontWeight: FontWeight.bold,
                ),
                const ColoredText(
                  'adjusting my size is easy too',
                  fontSize: 18,
                ),
                const SizedBox(height: 30),
                ColoredText(
                  'Tap screen to close',
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
