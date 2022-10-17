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
