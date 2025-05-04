import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:scale_up/hooks/use_animated_scroll_controller.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_learn_chapters.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_practice_chapters.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_progression.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_units.dart";

/// LessonInformation displays the lesson information,
///   specifically:
///     - Lesson Progression
///     - Lesson Units
///     - Lesson Learn Chapters
///     - Lesson Practice Chapters
class LessonInformation extends HookWidget {
  const LessonInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useAnimatedScrollController();

    return Material(
      child: SingleChildScrollView(
        controller: scrollController,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            spacing: 24.0,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LessonProgression(),
              LessonUnits(),
              LessonLearnChapters(),
              LessonPracticeChapters(),
            ],
          ),
        ),
      ),
    );
  }
}
