import "package:dotted_border/dotted_border.dart";
import "package:flutter/material.dart";

class DottedUnderline extends DottedBorder {
  // ignore: use_key_in_widget_constructors
  DottedUnderline({
    required super.child,
    super.color = Colors.black,
    super.strokeWidth = 1,
    super.borderType = BorderType.Rect,
    super.dashPattern = const <double>[3, 1],
    super.padding = const EdgeInsets.all(2),
    super.borderPadding = EdgeInsets.zero,
    super.radius = const Radius.circular(0),
    super.strokeCap = StrokeCap.butt,
    super.stackFit = StackFit.loose,
  }) : super(
         customPath: (size) {
           return Path()
             ..moveTo(0, size.height)
             ..lineTo(size.width, size.height);
         },
       );
}
