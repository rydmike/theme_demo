/// App name and info constants.
class AppConst {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  AppConst._();

  /// Name of the app.
  static const String appName = 'ThemeDemo';

  /// Current app version.
  static const String version = '0.9.8';

  /// Used version of FlexColorScheme package.
  static const String packageVersion = '7.1.2';

  /// Build with Flutter version.
  static const String flutterVersion = 'Channel stable v3.10.0';

  /// Copyright years notice.
  static const String copyright = '© 2021-2023';

  /// Author info.
  static const String author = 'Mike Rydstrom';

  /// License info.
  static const String license = 'BSD 3-Clause License';

  /// Link to the FlexColorScheme package.
  static final Uri packageUri = Uri(
    scheme: 'https',
    host: 'pub.dev',
    path: 'packages/flex_color_scheme',
  );
}
