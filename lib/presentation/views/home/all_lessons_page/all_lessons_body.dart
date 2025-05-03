import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/all_lessons_page/all_lessons_page_cubit.dart";
import "package:scale_up/presentation/views/home/all_lessons_page/lesson_group.dart";
import "package:scale_up/utils/animated_scroll_controller.dart";

class AllLessonsBody extends StatefulWidget {
  const AllLessonsBody({super.key});

  @override
  State<AllLessonsBody> createState() => _AllLessonsBodyState();
}

class _AllLessonsBodyState extends State<AllLessonsBody> {
  late final AnimatedScrollController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimatedScrollController();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AllLessonsPageCubit>().state;

    return SingleChildScrollView(
      controller: controller,
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
