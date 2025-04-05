import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/presentation/views/widgets/lesson_tile.dart";
import "package:scale_up/presentation/views/widgets/lesson_tile/lesson_progression.dart";

class LessonTileWhite extends StatelessWidget {
  const LessonTileWhite({super.key});

  @override
  Widget build(BuildContext context) {
    var Lesson(:id, :name, :units, :chapters, :color) = context.read();
    var questionsDone = context.select<UserDataBloc, int>(
      (bloc) => bloc.state.finishedChapters
          /// We only take the tags that start with this lesson
          .where((n) => n.startsWith(id))
          /// We take the string indices
          .map((v) => v.substring(id.length + 1))
          /// We parse the indices to integers
          .map((s) => int.parse(s))
          /// We get the chapter object from the lesson object, reading the questionCount.
          .map((s) => chapters[s].questionCount)
          /// And we sum them all up.
          .fold(0, (a, b) => a + b),
    );
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
              constraints: BoxConstraints(minWidth: 110, maxWidth: 160),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  Styles.caption(units.join(", "), overflow: TextOverflow.ellipsis),
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
                    LessonProgression(progressBarValue: progressBarValue, baseColor: color),
                    mini("${(progressBarValue * 100).round()}%"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
