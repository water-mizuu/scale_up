import "package:flutter/widgets.dart";
import "package:scale_up/utils/hsl_color_scheme.dart";

extension BorderColor on Color {
  Color get borderColor => HSLColor.fromColor(this).backgroundColor;
}
