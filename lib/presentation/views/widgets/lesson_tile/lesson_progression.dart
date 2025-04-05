import "package:flutter/material.dart";

class LessonProgression extends StatelessWidget {
  const LessonProgression({
    super.key,
    required this.progressBarValue,
    required this.baseColor,
  });

  final double progressBarValue;
  final Color baseColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18,
      height: 18,
      child: CircularProgressIndicator(
        padding: EdgeInsets.all(0.0),
        value: progressBarValue,
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(baseColor),
      ),
    );
  }
}
