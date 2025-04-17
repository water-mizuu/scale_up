import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/chapter.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_event.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_state.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/views/home/"
    "calculate_practice_page/calculate_practice_body.dart";
import "package:scale_up/presentation/views/home/"
    "calculate_practice_page/calculate_practice_description.dart";
import "package:scale_up/presentation/views/home/"
    "calculate_practice_page/completed_calculate_practice_body.dart";
import "package:scale_up/utils/snackbar_util.dart";

/// We assume that each instance of the ChapterPage is a new set of questions.
class CalculatePracticePage extends StatefulWidget {
  const CalculatePracticePage({required this.lessonId, required this.chapterIndex, super.key});

  final String lessonId;
  final int chapterIndex;

  @override
  State<CalculatePracticePage> createState() => _CalculatePracticePageState();
}

class _CalculatePracticePageState extends State<CalculatePracticePage> {
  late final Future<Lesson?> lessonFuture;
  PracticePageBloc? practicePageBloc;

  @override
  void initState() {
    super.initState();

    lessonFuture = context.read<LessonsHelper>().getLesson(widget.lessonId);
    lessonFuture
        .then((lesson) {
          if (!context.mounted || lesson == null) return;

          setState(() {
            practicePageBloc = PracticePageBloc(
              lessonsRepository: context.read(),
              lesson: lesson,
              chapterIndex: widget.chapterIndex,
            );
          });
        })
        .catchError((error) {
          var context = this.context;
          if (context.mounted) {
            context.showBasicSnackbar(error);
          }
        });
  }

  @override
  void dispose() {
    practicePageBloc?.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (practicePageBloc) {
      case null:
        return const Material(child: Center(child: CircularProgressIndicator()));
      case var chapterPageBloc:
        return BlocListener<PracticePageBloc, PracticePageState>(
          bloc: chapterPageBloc,
          listener: (context, state) async {
            switch (state) {
              case LoadedChapterPageState(:var error?):
                await context.showBasicSnackbar(error);

              /// These are the cases in which the user has answered.
              case LoadedChapterPageState(status: ChapterPageStatus.correct):
                await context.showBasicSnackbar("Correct!");

                if (context.mounted) {
                  chapterPageBloc.add(PracticePageNextQuestion());
                }
              case LoadedChapterPageState(status: ChapterPageStatus.incorrect):
                await context.showBasicSnackbar(
                  "Incorrect! The correct answer was: ${state.correctAnswer}",
                );

                if (context.mounted) {
                  chapterPageBloc.add(PracticePageNextQuestion());
                }
              case LoadedChapterPageState(status: ChapterPageStatus.finished):
                context.read<UserDataBloc>().add(
                  ChapterCompletedUserDataEvent(
                    lessonId: chapterPageBloc.state.lesson.id,
                    chapterIndex: chapterPageBloc.state.chapterIndex,
                  ),
                );
              case _:
                return;
            }
          },
          child: switch (chapterPageBloc.state) {
            InitialChapterPageState() => Material(
              child: const Center(child: CircularProgressIndicator()),
            ),
            LoadedChapterPageState state => BlocProvider.value(
              value: chapterPageBloc,
              child: ChapterPageView(lesson: state.lesson, chapterIndex: state.chapterIndex),
            ),
          },
        );
    }
  }
}

class ChapterPageView extends StatefulWidget {
  const ChapterPageView({required this.lesson, required this.chapterIndex, super.key});

  final Lesson lesson;
  final int chapterIndex;

  @override
  State<ChapterPageView> createState() => _ChapterPageViewState();
}

class _ChapterPageViewState extends State<ChapterPageView> {
  late final GlobalKey progressBarKey = GlobalKey();
  Chapter get chapter => widget.lesson.chapters[widget.chapterIndex];

  @override
  Widget build(BuildContext context) {
    var state = context.select((PracticePageBloc bloc) => bloc.state as LoadedChapterPageState);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: widget.lesson.color,
        foregroundColor: widget.lesson.foregroundColor,
      ),
      body: InheritedProvider.value(
        value: (widget.lesson, chapter, state.chapterIndex),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CalculatePracticeDescription(),
              if (state.status == ChapterPageStatus.finished)
                Expanded(child: CompletedCalculatePracticeBody(progressBarKey: progressBarKey))
              else
                Expanded(child: CalculatePracticeBody(progressBarKey: progressBarKey)),
            ],
          ),
        ),
      ),
    );
  }
}
