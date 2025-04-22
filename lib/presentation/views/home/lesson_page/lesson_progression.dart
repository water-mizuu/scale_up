import "package:flutter/material.dart";
import "package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/bloc/LessonPage/lesson_page_bloc.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class LessonProgression extends StatelessWidget {
  const LessonProgression({super.key});

  @override
  Widget build(BuildContext context) {
    var lesson = context.read<LessonPageCubit>().state.lesson;
    var Lesson(:id, :units, :practiceChapters, :learnChapters, :color, :hslColor) = lesson;

    var chaptersDone = context.select(
      (UserDataBloc bloc) => bloc.state.finishedChapters.where((n) => n.startsWith(id)).length,
    );
    var chapterCount = practiceChapters.length + learnChapters.length;
    var progressBarValue = chapterCount == 0 ? 0.0 : chaptersDone / chapterCount;
    var progressionBackgroundColor =
        hslColor
            .withLightness((hslColor.lightness + 0.25).clamp(0, 1))
            .withSaturation((hslColor.saturation) / 4)
            .toColor();

    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Styles.subtitle("Progression"),
        FAProgressBar(
          currentValue: progressBarValue * 100,
          progressColor: color,
          backgroundColor: progressionBackgroundColor,
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
          ],
        ),
      ],
    );
  }
}
