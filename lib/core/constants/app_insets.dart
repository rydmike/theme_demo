/// AppInsets represents the sizes used in this app, usually multiple of 2 in a
/// gradually increasing way, like 2, 4, 8, 16, 32, 64, ...
class AppInsets {
  // This class is not meant to be instantiated or extended. This constructor
  // prevents external instantiation and extension, plus it does not show up
  // in IDE code completion. We like static classes for constants because it
  // name spaces them and gives them a self documenting group and context that
  // they belong to.
  AppInsets._();
  static const double xs = 2;
  static const double s = 4;
  static const double m = 8;
  static const double l = 16;
  static const double xl = 32;
  static const double xxl = 64;

  // Edge padding for page content on the screen. A better looking result
  // can be obtained if this increases in steps depending on canvas size.
  // Keeping it fairly tight now, but not too small, it is a compromise for
  // both phone and larger media.
  static const double edge = 12;

  /// Max width of content pages with text thath should be read.
  ///
  /// The max dp width used for layout content on the screen in the available
  /// body area. Wider content gets growing side padding. Like on most
  /// web pages when they are used on super wide screen. To wide text gets
  /// difficult to read.
  static const double maxBodyWidth = 1000;

  /// The minimum media width treated as a phone device in this demo.
  static const double phoneWidthBreakpoint = 600;

  /// The minimum media height treated as a phone device in this demo.
  static const double phoneHeightBreakpoint = 700;
}
