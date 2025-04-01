import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:scale_up/presentation/views/authentication/widgets/lesson_progression.lesson_tile.dart";
import "package:scale_up/presentation/views/authentication/widgets/lesson_tile.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class LessonTileWhite extends StatelessWidget {
  const LessonTileWhite({super.key});

  // Length
  // Unit 1
  //
  // SI Units (m)

  @override
  Widget build(BuildContext context) {
    var LessonTileProps(
      :label,
      :sublabel,
      :questionsDone,
      :questionsTotal,
      :baseColor,
    ) = context.read<LessonTileProps>();
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
                  Text(label),
                  Text(
                    sublabel ?? "",
                    style: Styles.caption,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Row(
              spacing: 8.0,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$questionsDone/$questionsTotal", style: mini),
                Row(
                  spacing: 4.0,
                  children: [
                    LessonProgression(
                      progressBarValue: progressBarValue,
                      baseColor: baseColor,
                    ),
                    Text("${(progressBarValue * 100).round()}%", style: mini)
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
