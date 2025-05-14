import "dart:ui";

extension OffsetExtension<N extends num> on N {
  Offset get dx => Offset(toDouble(), 0.0);
  Offset get dy => Offset(0.0, toDouble());
}
