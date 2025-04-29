import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/lesson_tile.dart";
import "package:scale_up/presentation/views/home/widgets/lesson_tile/lesson_progression.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class LessonTileWhite extends StatelessWidget {
  const LessonTileWhite({super.key});

  @override
  Widget build(BuildContext context) {
    var Lesson(:id, :name, :units, :learnChapters, :practiceChapters, :color) = context.read();

    var chaptersDone = context.select(
      (UserDataBloc b) => b.state.finishedChapters.keys.where((c) => c.startsWith(id)).length,
    );
    var chaptersTotal = learnChapters.length + practiceChapters.length;
    var progressBarValue = chaptersTotal == 0 ? 0.0 : chaptersDone / chaptersTotal;

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
                mini("$chaptersDone/$chaptersTotal"),
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
