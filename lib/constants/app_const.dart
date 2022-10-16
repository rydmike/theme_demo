/// Layout constants and strings used in the example application
class AppConst {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  AppConst._();

  // This info is mainly for the Live public web builds of the examples.
  // When I build a new public version I just make sure to update this info
  // before building them.
  static const String appName = 'ThemeDemo';
  static const String keyValueFilename = 'settings_box';
  static const String version = '0.8.0';
  static const String packageVersion = '6.0.1';
  static const String flutterVersion = 'Channel stable v3.3.4';
  static const String copyright = '© 2020, 2021, 2022';
  static const String author = 'Mike Rydstrom';
  static const String license = 'BSD 3-Clause License';
  static const String icon = 'assets/images/app_icon.png';
  static final Uri packageUri = Uri(
    scheme: 'https',
    host: 'pub.dev',
    path: 'packages/flex_color_scheme',
  );

  // The max dp width used for layout content on the screen in the available
  // body area. Wider content gets growing side padding, kind of like on most
  // web pages when they are used on super wide screen. Just a design used for
  // this demo app, that works pretty well in this use case.
  static const double maxBodyWidth = 1000;

  // The minimum media size needed for desktop/large tablet menu view,
  // this is media size.
  // Only at higher than this breakpoint will the menu expand from rail and
  // be possible to toggle between menu and rail. Below this breakpoint it
  // toggles between hidden in the Drawer and being a Rail, also on phones.
  // This size was chosen because in combination codeViewWidthBreakpoint, it
  // gives us a breakpoint where we get code side by side view in desktop
  // rail mode already, and when it switches to menu mode, the desktop is
  // wide enough to show both the full width menu and keep showing the
  // code in side-by-side view. We could do lower the desktop width breakpoint,
  // but then that view switches temporarily to now showing the code view,
  // and it is just to much dynamic changes happening, it does not nice.
  static const double desktopWidthBreakpoint = 1350;
  // This breakpoint is only used to further increase margins and insets on
  // very large desktops.
  static const double bigDesktopWidthBreakpoint = 2800;
  // The minimum media width treated as a phone device in this demo.
  static const double phoneWidthBreakpoint = 600;
  // The minimum media height treated as a phone device in this demo.
  static const double phoneHeightBreakpoint = 700;
}

/// Fonts assets used in this application,
class AppFonts {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  AppFonts._();

  // We use usage specific terms like mainFont and logoFont in the code,
  // not actual font names. These names then refer to const strings containing
  // the actual used font name.
  static const String mainFont = fontRoboto;

  // We use Roboto as an asset so we can get it on all platforms and have same
  // look. If we do not do this, then on some platforms we will instead get a
  // Roboto 'like' font as replacement font. In this app we want to make sure
  // we actually use Roboto on all platforms. So we provide it as a bundled
  // asset and also specify it in our theme explicitly via the mainFont.
  static const String fontRoboto = 'Roboto';
}
