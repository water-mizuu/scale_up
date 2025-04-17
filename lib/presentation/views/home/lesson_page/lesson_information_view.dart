import "package:flutter/material.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_practice_chapters.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_progression.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_units.dart";

class LessonInformationView extends StatelessWidget {
  const LessonInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
        spacing: 24.0,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [LessonProgression(), LessonUnits(), LessonPracticeChapters()],
      ),
    );
  }
}
