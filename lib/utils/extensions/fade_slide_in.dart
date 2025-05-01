import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";

extension FadeSlideInExtension on Animate {
  Animate slideFadeIn() {
    return fadeIn().slideY(
      begin: -0.1,
      end: 0.0,
      duration: 500.ms,
      curve: Curves.linearToEaseOut,
    );
  }
}
