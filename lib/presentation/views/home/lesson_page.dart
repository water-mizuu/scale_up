import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/bloc/LessonPage/lesson_page_bloc.dart";
import "package:scale_up/presentation/views/home/lesson_page/blank_lesson_page.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_header.dart";
import "package:scale_up/utils/snackbar_util.dart";

class LessonPage extends StatefulWidget {
  const LessonPage({required this.id, required this.child, super.key});

  final String id;
  final Widget child;

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  late final Future<Lesson?> lessonFuture;

  @override
  void initState() {
    super.initState();

    lessonFuture = context.read<LessonsHelper>().getLesson(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: lessonFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          context.showBasicSnackbar(snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        assert(snapshot.hasData);
        switch (snapshot.data) {
          case Lesson lesson:
            return BlocProvider(
              create: (_) => LessonPageCubit(context.read(), lesson),
              child: LessonPageView(lesson: lesson, child: widget.child),
            );
          case null:
            return BlankLessonPage(id: widget.id);
        }
      },
    );
  }
}

class LessonPageView extends StatelessWidget {
  const LessonPageView({required this.lesson, required this.child, super.key});

  final Lesson lesson;
  final Widget child;

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
      body: InheritedProvider.value(
        value: lesson,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          /// Description
          children: [LessonHeader(), Expanded(child: child)],
        ),
      ),
    );
  }
}
