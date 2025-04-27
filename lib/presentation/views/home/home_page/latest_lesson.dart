import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/presentation/views/home/widgets/newer_lesson_tile.dart";

class LatestLesson extends StatelessWidget {
  const LatestLesson({super.key});

  @override
  Widget build(BuildContext context) {
    (_) = context.watch<LessonsHelper>();

    final lessons = context.read<LessonsHelper>().lessons;

    return NewerLessonTile(lesson: lessons.last, isHighlighted: true);
  }
}
