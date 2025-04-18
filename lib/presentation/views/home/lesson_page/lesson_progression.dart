import "package:flutter/material.dart";
import "package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart";
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

    var chaptersDone = context.select(
      (UserDataBloc bloc) => bloc.state.finishedChapters.where((n) => n.startsWith(id)).length,
    );
    var chaptersTotal = chapters.length;
    var progressBarValue = chaptersTotal == 0 ? 0.0 : chaptersDone / chaptersTotal;
    var hslColor = HSLColor.fromColor(color);

    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Styles.subtitle("Progression"),
        FAProgressBar(
          currentValue: progressBarValue * 100,
          progressColor: color,
          backgroundColor:
              hslColor
                  .withLightness((hslColor.lightness + 0.25).clamp(0, 1))
                  .withSaturation((hslColor.saturation) / 4)
                  .toColor(),
          borderRadius: BorderRadius.circular(24.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Styles.body(
              "$chaptersDone / $chapterCount chapters",
              color: color,
              textAlign: TextAlign.right,
            ),
            Styles.body(
              "$chaptersDone / $questionCount questions",
              color: color,
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ],
    );
  }
}
