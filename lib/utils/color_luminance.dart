import "package:flutter/material.dart";

extension ColorLuminanceExtension on Color {
  static final Expando<Color> _contrastingExpando = Expando<Color>();

  Color contrastingTextColor() {
    return _contrastingExpando[this] ??= switch (computeLuminance()) {
      > 0.5 => Colors.black,
      _ => Colors.white,
    };
  }
}
