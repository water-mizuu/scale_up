import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/views/home/lesson_page/chapter_tile.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_practice_chapters.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_progression.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_units.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/animated_scroll_controller.dart";

/// LessonInformation displays the lesson information,
///   specifically:
///     - Lesson Progression
///     - Lesson Units
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
        child: const LessonInformationView(),
      ),
    );
  }
}

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
        children: [
          LessonProgression(),
          LessonUnits(),
          Column(
            spacing: 8.0,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Styles.subtitle("Learn"),
              Column(
                spacing: 4.0,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var (index, chapter) in context.read<Lesson>().chapters.indexed)
                    ChapterTile(index: index, chapter: chapter),
                ],
              ),
            ],
          ),
          LessonPracticeChapters(),
        ],
      ),
    );
  }
}
