import "package:flutter/material.dart";

class Styles {
  static const TextStyle title = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static const TextStyle subtitle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static const TextStyle tile = TextStyle(fontSize: 14);
  static const TextStyle body = TextStyle(fontSize: 12);
  static const TextStyle caption = TextStyle(fontSize: 10);
  static const TextStyle button = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static const TextStyle link = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.indigo,
  );
  static const TextStyle error = TextStyle(fontSize: 14, color: Colors.red);
}

extension StylesShortcutExtension on TextStyle {
  Text call(
    String text, {
    final StrutStyle? strutStyle,
    final TextAlign? textAlign,
    final TextDirection? textDirection,
    final Locale? locale,
    final bool? softWrap,
    final TextOverflow? overflow,
    final TextScaler? textScaler,
    final int? maxLines,
    final String? semanticsLabel,
    final TextWidthBasis? textWidthBasis,
    final TextHeightBehavior? textHeightBehavior,
    final Color? selectionColor,
    final bool? inherit,
    final Color? color,
    final Color? backgroundColor,
    final double? fontSize,
    final FontWeight? fontWeight,
    final FontStyle? fontStyle,
    final double? letterSpacing,
    final double? wordSpacing,
    final TextBaseline? textBaseline,
    final double? height,
    final TextLeadingDistribution? leadingDistribution,
    final Paint? foreground,
    final Paint? background,
    final List<Shadow>? shadows,
    final List<FontFeature>? fontFeatures,
    final List<FontVariation>? fontVariations,
    final TextDecoration? decoration,
    final Color? decorationColor,
    final TextDecorationStyle? decorationStyle,
    final double? decorationThickness,
    final String? debugLabel,
    final String? fontFamily,
    final List<String>? fontFamilyFallback,
    final String? package,
  }) {
    return Text(
      text,
      style: copyWith(
        inherit: inherit,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        overflow: overflow,
      ),
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}
