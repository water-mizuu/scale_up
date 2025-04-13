import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class LessonProgression extends StatelessWidget {
  const LessonProgression({super.key});

  @override
  Widget build(BuildContext context) {
    var Lesson(:id, :name, :units, :chapters, :color, :chapterCount, :questionCount) =
        context.read();

    var chaptersDone = context.select<UserDataBloc, int>(
      (bloc) => bloc.state.finishedChapters.where((n) => n.startsWith(id)).length,
    );
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

    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Styles.subtitle("Progression"),
        LinearProgressIndicator(value: progressBarValue, color: color),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Styles.body(
              "$chaptersDone / $chapterCount chapters",
              color: color,
              textAlign: TextAlign.right,
            ),
            Styles.body(
              "$questionsDone / $questionCount questions",
              color: color,
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ],
    );
  }
}
