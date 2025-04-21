import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/bloc/LessonPage/lesson_page_bloc.dart";
import "package:scale_up/presentation/views/home/lesson_page/blank_lesson_page.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_header.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_information.dart";

class LessonPage extends StatefulWidget {
  const LessonPage({required this.id, super.key});

  final String id;

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  @override
  Widget build(BuildContext context) {
    var lesson = context.read<LessonsHelper>().getLesson(widget.id);
    if (lesson == null) {
      return const BlankLessonPage(id: "");
    }

    return MultiProvider(
      providers: [BlocProvider(create: (_) => LessonPageCubit(context.read(), lesson))],
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
        leading: Builder(
          builder: (context) {
            if (!context.canPop()) {
              return const SizedBox();
            }
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => context.pop(),
            );
          },
        ),
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: lesson.color,
        foregroundColor: lesson.foregroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        /// Description
        children: [LessonHeader(), Expanded(child: LessonInformation())],
      ),
    );
  }
}
