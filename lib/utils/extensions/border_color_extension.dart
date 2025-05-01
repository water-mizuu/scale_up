import "package:flutter/widgets.dart";
import "package:scale_up/utils/extensions/hsl_color_scheme_extension.dart";

extension BorderColorExtension on Color {
  Color get borderColor => HSLColor.fromColor(this).backgroundColor;
}
