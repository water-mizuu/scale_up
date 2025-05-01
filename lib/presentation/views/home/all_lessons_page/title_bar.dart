import "package:flutter/material.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Styles.title("Available Lessons", textAlign: TextAlign.left);
  }
}
