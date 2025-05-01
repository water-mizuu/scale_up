import "package:flutter/material.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_learn_chapters.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_practice_chapters.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_progression.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_units.dart";
import "package:scale_up/utils/animated_scroll_controller.dart";

/// LessonInformation displays the lesson information,
///   specifically:
///     - Lesson Progression
///     - Lesson Units
///     - Lesson Learn Chapters
///     - Lesson Practice Chapters
class LessonInformation extends StatefulWidget {
  const LessonInformation({super.key});

  @override
  State<LessonInformation> createState() => _LessonInformationState();
}

class _LessonInformationState extends State<LessonInformation> {
  late final AnimatedScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = AnimatedScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
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
