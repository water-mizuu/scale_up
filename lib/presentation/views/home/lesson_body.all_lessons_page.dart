import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/LessonsPage/lessons_page_cubit.dart";
import "package:scale_up/presentation/views/home/lesson_group.all_lessons_page.dart";

class LessonBody extends StatelessWidget {
  const LessonBody({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<LessonsPageCubit>().state;

    return SingleChildScrollView(
      child: Column(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var (key, value) in state.categoriesByTitle) //
            LessonGroup(
              categoryName: key,
              lessons: value,
            ),
        ],
      ),
    );
  }
}
