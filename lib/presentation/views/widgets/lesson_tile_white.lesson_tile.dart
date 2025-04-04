import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository/lesson.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/presentation/views/widgets/lesson_progression.lesson_tile.dart";
import "package:scale_up/presentation/views/widgets/lesson_tile.dart";

class LessonTileWhite extends StatelessWidget {
  const LessonTileWhite({super.key});

  @override
  Widget build(BuildContext context) {
    var Lesson(:name, :units, :chapters, :color) = context.read();

    /// TODO: Replace with actual data soon.
    var questionsDone = 0;
    var questionsTotal = chapters.map((c) => c.questionCount).fold(0, (a, b) => a + b);
    var progressBarValue = questionsTotal == 0 ? 0.0 : questionsDone / questionsTotal;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          spacing: 20.0,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 110,
                maxWidth: 160,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  Styles.caption(
                    units.join(", "),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Row(
              spacing: 8.0,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                mini("$questionsDone/$questionsTotal"),
                Row(
                  spacing: 4.0,
                  children: [
                    LessonProgression(
                      progressBarValue: progressBarValue,
                      baseColor: color,
                    ),
                    mini("${(progressBarValue * 100).round()}%")
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
