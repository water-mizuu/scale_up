import "package:flutter/material.dart";
import "package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart";

class ColoredProgressBar extends StatelessWidget {
  const ColoredProgressBar({
    super.key,
    required this.progressBarKey,
    required this.progress,
    required this.hslColor,
  });

  final GlobalKey progressBarKey;
  final double progress;
  final HSLColor hslColor;

  @override
  Widget build(BuildContext context) {
    return FAProgressBar(
      key: progressBarKey,
      size: 4,
      currentValue: (progress * 100).floorToDouble(),
      borderRadius: BorderRadius.circular(24.0),
      progressColor: hslColor.toColor(),
      backgroundColor:
          hslColor
              .withLightness((hslColor.lightness + 0.25).clamp(0, 1))
              .withSaturation((hslColor.saturation) / 4)
              .toColor(),
      animatedDuration: const Duration(milliseconds: 150),
    );
  }
}
