import "package:flutter/widgets.dart";

extension HslColorSchemeExtension on HSLColor {
  Color get backgroundColor => withSaturation(saturation * 0.8).withLightness(0.95).toColor();
  Color get borderColor => withSaturation(saturation * 0.8).withLightness(0.9).toColor();
}

extension ColorSchemeExtension on Color {
  Color get backgroundColor => HSLColor.fromColor(this).backgroundColor;
  Color get borderColor => HSLColor.fromColor(this).borderColor;
}
