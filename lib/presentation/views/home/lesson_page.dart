import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/presentation/bloc/lesson_page/lesson_page_bloc.dart";
import "package:scale_up/presentation/views/home/lesson_page/blank_lesson_page.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_header.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_information.dart";

class LessonPage extends StatelessWidget {
  const LessonPage({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    var lesson = context.read<LessonsHelper>().getLesson(id);
    if (lesson == null) {
      return const BlankLessonPage(id: "");
    }

    return MultiProvider(
      providers: [
        BlocProvider(key: ValueKey(id), create: (_) => LessonPageCubit(context.read(), lesson)),
      ],
      child: LessonPageView(lesson: lesson),
    );
  }
}

class LessonPageView extends StatelessWidget {
  const LessonPageView({required this.lesson, super.key});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => context.pop(),
            child: const Icon(Icons.arrow_back_ios_new, size: 18.0),
          ),
        ),
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: lesson.color,
        foregroundColor: lesson.foregroundColor,
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [LessonHeader(), Expanded(child: LessonInformation())],
      ),
    );
  }
}
