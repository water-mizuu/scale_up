import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/LessonPage/lesson_page_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/box_shadow.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class LessonHeader extends StatelessWidget {
  const LessonHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var lesson = context.read<LessonPageCubit>().state.lesson;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: lesson.color,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
        boxShadow: defaultBoxShadow,
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 4.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Styles.title(lesson.name, color: lesson.foregroundColor),
            Styles.body(lesson.description, color: lesson.foregroundColor),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
