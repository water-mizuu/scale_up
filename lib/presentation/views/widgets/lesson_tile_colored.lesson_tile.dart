import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository/lesson.dart";
import "package:scale_up/utils/color_luminance.dart";

class LessonTileColored extends StatelessWidget {
  const LessonTileColored({super.key});

  @override
  Widget build(BuildContext context) {
    var Lesson(:color) = context.read();

    return Container(
      padding: const EdgeInsets.all(8.0) + const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          colors: [
            color,
            color.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.check,
          color: color.contrastingTextColor(),
          size: 18.0,
        ),
      ),
    );
  }
}
