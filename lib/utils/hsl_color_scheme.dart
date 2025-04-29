import "package:flutter/widgets.dart";

extension HslColorScheme on HSLColor {
  Color get backgroundColor => withSaturation(saturation * 0.8).withLightness(0.95).toColor();
  Color get borderColor => withSaturation(saturation * 0.8).withLightness(0.85).toColor();
}
