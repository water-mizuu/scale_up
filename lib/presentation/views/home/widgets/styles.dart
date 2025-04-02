import "package:flutter/material.dart";

class Styles {
  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle body = TextStyle(
    fontSize: 12,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 10,
  );
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle link = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.indigo,
  );
  static const TextStyle error = TextStyle(
    fontSize: 14,
    color: Colors.red,
  );
}

extension StylesShortcutExtension on TextStyle {
  Text call(
    String text, {
    final TextStyle? style,
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
  }) {
    return Text(
      text,
      style: style == null
          ? this
          : copyWith(
              inherit: style.inherit,
              color: style.color,
              backgroundColor: style.backgroundColor,
              fontSize: style.fontSize,
              fontWeight: style.fontWeight,
              fontStyle: style.fontStyle,
              letterSpacing: style.letterSpacing,
              wordSpacing: style.wordSpacing,
              textBaseline: style.textBaseline,
              height: style.height,
              leadingDistribution: style.leadingDistribution,
              locale: style.locale,
              foreground: style.foreground,
              background: style.background,
              shadows: style.shadows,
              fontFeatures: style.fontFeatures,
              fontVariations: style.fontVariations,
              decoration: style.decoration,
              decorationColor: style.decorationColor,
              decorationStyle: style.decorationStyle,
              decorationThickness: style.decorationThickness,
              debugLabel: style.debugLabel,
              fontFamily: style.fontFamily,
              fontFamilyFallback: style.fontFamilyFallback,
              overflow: style.overflow,
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
