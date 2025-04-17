import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/views/home/lesson_page/chapter_tile.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class LessonPracticeChapters extends StatelessWidget {
  const LessonPracticeChapters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Styles.subtitle("Lesson Practice"),
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
    );
  }
}
