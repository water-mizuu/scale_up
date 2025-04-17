import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/chapter.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class CalculatePracticeDescription extends StatelessWidget {
  const CalculatePracticeDescription({super.key});

  @override
  Widget build(BuildContext context) {
    var (lesson, chapter, chapterIndex) = context.read<(Lesson, Chapter, int)>();

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: lesson.color,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        spacing: 4.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Styles.title(
            "${lesson.name} - Chapter ${chapterIndex + 1}",
            color: lesson.foregroundColor,
          ),
          Styles.body(lesson.description, color: lesson.foregroundColor),
          const SizedBox(height: 4.0),
        ],
      ),
    );
  }
}
