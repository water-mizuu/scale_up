import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/presentation/views/home/widgets/lesson_tile.dart";

class FeaturedLesson extends StatelessWidget {
  const FeaturedLesson({super.key});

  @override
  Widget build(BuildContext context) {
    (_) = context.watch<LessonsHelper>();

    final lessons = context.read<LessonsHelper>().lessons;

    return LessonTile(lesson: lessons.last);
  }
}
