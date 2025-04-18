import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/AllLessonsPage/all_lessons_page_cubit.dart";
import "package:scale_up/presentation/views/home/all_lessons_page/lesson_group.dart";

class AllLessonsBody extends StatelessWidget {
  const AllLessonsBody({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AllLessonsPageCubit>().state;

    return SingleChildScrollView(
      child: Column(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var (key, value) in state.categoriesByTitle) //
            LessonGroup(categoryName: key, lessons: value),
        ],
      ),
    );
  }
}
