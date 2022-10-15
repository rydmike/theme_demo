import 'dart:ui' as ui show TextHeightBehavior;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore_for_file: comment_references

/// A run of colored text with a single style.
///
/// The [ColoredText] widget displays a string of text with single style. The
/// string might break across multiple lines or might all be displayed on the
/// same line depending on the layout constraints.
///
/// The [ColoredText] defaults to using Theme.of(context).colorScheme.primary
/// as its text color. It also exposes the [color], [fontWeight] and [fontSize]
/// as direct properties in the widget, without need to provide them via
/// a [TextStyle] in [style]. A [style] may also be provided, if given then
/// the [color], [fontWeight] and [fontSize] given via direct properties
/// override the same properties in the [style].
///
/// The [color] property gets a default of [primary] if null before merging
/// with [style], so if [color] is null, but a [style] is given, with or
/// without [color] set in it, it will always be [primary] colored anyway, this
/// is an always colored text widget after all and one design goal was for it
/// to always default to primary color.
///
/// The [ColoredText] is a simple modified version of Flutter SDK [Text]. The
/// rest of the comments are straight copies from the SDK.
///
/// The [style] argument is optional. When omitted, the text will use the style
/// from the closest enclosing [DefaultTextStyle]. If the given style's
/// [TextStyle.inherit] property is true (the default), the given style will
/// be merged with the closest enclosing [DefaultTextStyle]. This merging
/// behavior is useful, for example, to make the text bold while using the
/// default font family and size.
///
/// ## Interactivity
///
/// To make [ColoredText] react to touch events, wrap it in a [GestureDetector]
/// widget with a [GestureDetector.onTap] handler.
///
/// In a material design application, consider using a [TextButton] instead, or
/// if that isn't appropriate, at least using an [InkWell] instead of
/// [GestureDetector].
///
/// To make sections of the text interactive, use [RichText] and specify a
/// [TapGestureRecognizer] as the [TextSpan.recognizer] of the relevant part of
/// the text.
///
/// See also:
///
///  * [RichText], which gives you more control over the text styles.
///  * [DefaultTextStyle], which sets default styles for [ColoredText] widgets.
class ColoredText extends StatelessWidget {
  /// Creates a colored text widget.
  ///
  /// The [ColoredText] defaults to using Theme.of(context).colorScheme.primary
  /// as its text color. It also exposes the [color], [fontWeight]
  /// and [fontSize] as direct properties in the widget, without need to provide
  /// them via a [TextStyle] in [style]. A [style] may also be provided, if
  /// given then the [color], [fontWeight] and [fontSize] given via direct
  /// properties override the same properties in the [style].
  ///
  /// The [color] property gets a default of [primary] if null before merging
  /// with [style], so if [color] is null, but a [style] is given, with or
  /// without [color] set in it, it will always be [primary] colored anyway,
  /// this is an always colored text widget after all and one design goal was
  /// for it to always default to primary color.
  ///
  /// If the [style] argument is null, the text will use the style from the
  /// closest enclosing [DefaultTextStyle].
  ///
  /// The [data] parameter must not be null.
  ///
  /// The [overflow] property's behavior is affected by the [softWrap] argument.
  /// If the [softWrap] is true or null, the glyph causing overflow, and those
  /// that follow, will not be rendered. Otherwise, it will be shown with the
  /// given overflow option.
  const ColoredText(
    String this.data, {
    super.key,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  })  : textSpan = null;

  /// Creates a colored text widget with a [InlineSpan].
  ///
  /// The following subclasses of [InlineSpan] may be used to build rich text:
  ///
  /// * [TextSpan]s define text and children [InlineSpan]s.
  /// * [WidgetSpan]s define embedded inline widgets.
  ///
  /// The [textSpan] parameter must not be null.
  ///
  /// See [RichText] which provides a lower-level way to draw text.
  const ColoredText.rich(
    InlineSpan this.textSpan, {
    super.key,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  })  : data = null;

  /// The text to display.
  ///
  /// This will be null if a [textSpan] is provided instead.
  final String? data;

  /// The text to display as a [InlineSpan].
  ///
  /// This will be null if [data] is provided instead.
  final InlineSpan? textSpan;

  /// The color to use when painting the text.
  ///
  /// The [color] property gets a default of [primary] color if it is null,
  /// before merging with [style], so if [color] is null, but a [style] is
  /// given, with or without [color] set in it, it will always be [primary]
  /// colored anyway. This is an always colored text widget after all and
  /// one design goal was for it to always default to primary color if not
  /// specified in the direct [color] property to use some other color.
  ///
  /// Since this property will always resolve to a none null color value, it
  /// does mean that this widget cannot specify the [foreground] color in
  /// [style] property, doing so will result in an assert informing you of
  /// the conflict.
  ///
  /// In [merge], [apply], and [lerp], conflicts between [color] and
  /// [foreground] specification are resolved in [foreground]'s favor - i.e. if
  /// [foreground] is specified in one place, it will dominate [color] in
  /// another.
  final Color? color;

  /// The size of glyphs (in logical pixels) to use when painting the text.
  ///
  /// During painting, the [fontSize] is multiplied by the current
  /// `textScaleFactor` to let users make it easier to read text by increasing
  /// its size.
  ///
  /// [getParagraphStyle] will default to 14 logical pixels if the font size
  /// isn't specified here.
  final double? fontSize;

  /// The typeface thickness to use when painting the text (e.g., bold).
  final FontWeight? fontWeight;

  /// If non-null, the style to use for this text.
  ///
  /// If the style's "inherit" property is true, the style will be merged with
  /// the closest enclosing [DefaultTextStyle]. Otherwise, the style will
  /// replace the closest enclosing [DefaultTextStyle].
  final TextStyle? style;

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle? strutStyle;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [data] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any.
  final TextDirection? textDirection;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with
  /// `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale? locale;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was
  /// unlimited horizontal space.
  final bool? softWrap;

  /// How visual overflow should be handled.
  ///
  /// Defaults to retrieving the value from the nearest [DefaultTextStyle]
  /// ancestor.
  final TextOverflow? overflow;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  ///
  /// The value given to the constructor as textScaleFactor. If null, will
  /// use the [MediaQueryData.textScaleFactor] obtained from the ambient
  /// [MediaQuery], or 1.0 if there is no [MediaQuery] in scope.
  final double? textScaleFactor;

  /// An optional maximum number of lines for the text to span, wrapping if
  /// necessary. If the text exceeds the given number of lines, it will be
  /// truncated according to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  ///
  /// If this is null, but there is an ambient [DefaultTextStyle] that specifies
  /// an explicit number for its [DefaultTextStyle.maxLines], then the
  /// [DefaultTextStyle] value will take precedence. You can use a [RichText]
  /// widget directly to entirely override the [DefaultTextStyle].
  final int? maxLines;

  /// An alternative semantics label for this text.
  ///
  /// If present, the semantics of this widget will contain this value instead
  /// of the actual text. This will overwrite any of the semantics labels
  /// applied directly to the [TextSpan]s.
  ///
  /// This is useful for replacing abbreviations or shorthands with the full
  /// text value:
  ///
  /// ```dart
  /// Text(r'$$', semanticsLabel: 'Double dollars')
  /// ```
  final String? semanticsLabel;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis? textWidthBasis;

  /// {@macro flutter.dart:ui.textHeightBehavior}
  final ui.TextHeightBehavior? textHeightBehavior;

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = style;
    if (style == null || style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(style);
    }
    effectiveTextStyle = effectiveTextStyle!.merge(
      TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
    );
    if (MediaQuery.boldTextOverride(context)) {
      effectiveTextStyle = effectiveTextStyle
          .merge(const TextStyle(fontWeight: FontWeight.bold));
    }

    Widget result = RichText(
      textAlign: textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap ?? defaultTextStyle.softWrap,
      overflow: overflow ?? defaultTextStyle.overflow,
      textScaleFactor: textScaleFactor ?? MediaQuery.textScaleFactorOf(context),
      maxLines: maxLines ?? defaultTextStyle.maxLines,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis ?? defaultTextStyle.textWidthBasis,
      textHeightBehavior: textHeightBehavior ??
          defaultTextStyle.textHeightBehavior ??
          DefaultTextHeightBehavior.of(context),
      text: TextSpan(
        style: effectiveTextStyle,
        text: data,
        children: textSpan != null ? <InlineSpan>[textSpan!] : null,
      ),
    );
    if (semanticsLabel != null) {
      result = Semantics(
        textDirection: textDirection,
        label: semanticsLabel,
        child: ExcludeSemantics(
          child: result,
        ),
      );
    }
    return result;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('data', data, showName: false));
    if (textSpan != null) {
      properties.add(textSpan!.toDiagnosticsNode(
          name: 'textSpan', style: DiagnosticsTreeStyle.transition));
    }
    properties.add(ColorProperty('color', color, defaultValue: null));
    properties.add(DoubleProperty('fontSize', fontSize, defaultValue: null));
    properties.add(
        EnumProperty<FontWeight>('fontWeight', fontWeight, defaultValue: null));
    style?.debugFillProperties(properties);
    properties.add(
        EnumProperty<TextAlign>('textAlign', textAlign, defaultValue: null));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection,
        defaultValue: null));
    properties
        .add(DiagnosticsProperty<Locale>('locale', locale, defaultValue: null));
    properties.add(FlagProperty('softWrap',
        value: softWrap,
        ifTrue: 'wrapping at box width',
        ifFalse: 'no wrapping except at line break characters',
        showName: true));
    properties.add(
        EnumProperty<TextOverflow>('overflow', overflow, defaultValue: null));
    properties.add(
        DoubleProperty('textScaleFactor', textScaleFactor, defaultValue: null));
    properties.add(IntProperty('maxLines', maxLines, defaultValue: null));
    properties.add(EnumProperty<TextWidthBasis>(
        'textWidthBasis', textWidthBasis,
        defaultValue: null));
    properties.add(DiagnosticsProperty<ui.TextHeightBehavior>(
        'textHeightBehavior', textHeightBehavior,
        defaultValue: null));
    if (semanticsLabel != null) {
      properties.add(StringProperty('semanticsLabel', semanticsLabel));
    }
    properties.add(DiagnosticsProperty<StrutStyle?>('strutStyle', strutStyle));
  }
}
