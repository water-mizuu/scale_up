import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_event.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_state.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/views/home/"
    "calculate_practice_page/calculate_practice_body.dart";
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

  /// We create a bloc asynchronously, after loading the lesson.
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
    var practicePageBloc = this.practicePageBloc;
    if (practicePageBloc == null) {
      return const Material(child: Center(child: CircularProgressIndicator()));
    }

    return Material(
      child: BlocListener<PracticePageBloc, PracticePageState>(
        bloc: practicePageBloc,
        listener: (context, state) async {
          switch (state) {
            /// If there is an error, we show a snackbar.
            case LoadedChapterPageState(:var error?):
              await context.showBasicSnackbar(error);

            /// These are the cases in which the user has answered.
            case LoadedChapterPageState(status: ChapterPageStatus.correct):
              await context.showBasicSnackbar("Correct!");

              if (context.mounted) {
                practicePageBloc.add(PracticePageNextQuestion());
              }
            case LoadedChapterPageState(status: ChapterPageStatus.incorrect):
              await context.showBasicSnackbar(
                "Incorrect! The correct answer was: ${state.correctAnswer}",
              );

              if (context.mounted) {
                practicePageBloc.add(PracticePageNextQuestion());
              }

            /// If the chapter is finished, then we let the bloc know
            ///   that the user has completed the chapter.
            /// This will trigger the UserDataBloc to update the stored local data.
            ///   This will also asynchronously update the server data.
            case LoadedChapterPageState(status: ChapterPageStatus.finished):
              context.read<UserDataBloc>().add(
                ChapterCompletedUserDataEvent(
                  lessonId: practicePageBloc.state.lesson.id,
                  chapterIndex: practicePageBloc.state.chapterIndex,
                ),
              );
            case _:
              return;
          }
        },
        child: switch (practicePageBloc.state) {
          /// If we are loading the chapter, we show a progress indicator.
          InitialChapterPageState() => Material(
            child: const Center(child: CircularProgressIndicator()),
          ),

          /// If the chapter is loaded, we show the chapter page.
          LoadedChapterPageState() => MultiProvider(
            providers: [
              BlocProvider.value(value: practicePageBloc),

              /// We expose a single HSLColor which will be used
              ///   by the different widgets in the tree.
              InheritedProvider(
                create: (_) => HSLColor.fromColor(practicePageBloc.state.lesson.color),
              ),
            ],
            child: ChapterPageView(),
          ),
        },
      ),
    );
  }
}

class ChapterPageView extends StatefulWidget {
  const ChapterPageView({super.key});

  @override
  State<ChapterPageView> createState() => _ChapterPageViewState();
}

class _ChapterPageViewState extends State<ChapterPageView> {
  late final GlobalKey progressBarKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var state = context.select((PracticePageBloc bloc) => bloc.state as LoadedChapterPageState);

    if (state.status == ChapterPageStatus.finished) {
      return CompletedCalculatePracticeBody(progressBarKey: progressBarKey);
    }
    return CalculatePracticeBody(progressBarKey: progressBarKey);
  }
}
