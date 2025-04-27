import "package:flutter/material.dart";
import "package:scale_up/presentation/views/home/home_page/latest_lesson.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class LatestLessonContainer extends StatelessWidget {
  const LatestLessonContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8.0,
      children: [
        Styles.hint("Continue your latest lesson!"),
        LatestLesson(),
      ],
    );
  }
}
