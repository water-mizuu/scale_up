import "package:flutter/material.dart";
import "package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/presentation/bloc/lesson_page/lesson_page_bloc.dart";
import "package:scale_up/presentation/bloc/user_data/user_data_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class LessonProgression extends StatelessWidget {
  const LessonProgression({super.key});

  @override
  Widget build(BuildContext context) {
    var lesson = context.read<LessonPageCubit>().state.lesson;
    var Lesson(:id, :units, :practiceChapters, :learnChapters, :color, :hslColor) = lesson;

    var chaptersDone = context.select((UserDataBloc bloc) {
      return bloc.state.finishedChapters.keys.where((n) => n.startsWith(id)).length;
    });
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
        Styles.subtitle("Progress", fontWeight: FontWeight.w600),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              FAProgressBar(
                size: 8.0,
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
          ),
        ),
      ],
    );
  }
}
