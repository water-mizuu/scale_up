import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_event.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_state.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/views/home/practice_page/completed_practice_body.dart";
import "package:scale_up/presentation/views/home/practice_page/practice_body.dart";
import "package:scale_up/utils/snackbar_util.dart";

/// We assume that each instance of the ChapterPage is a new set of questions.
class PracticePage extends StatefulWidget {
  const PracticePage({required this.lessonId, required this.chapterIndex, super.key});

  final String lessonId;
  final int chapterIndex;

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
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
            case LoadedPracticePageState(:var error?):
              await context.showBasicSnackbar(error);

            /// These are the cases in which the user has answered.
            case LoadedPracticePageState(status: ChapterPageStatus.correct):
              await context.showBasicSnackbar("Correct!");

              if (context.mounted) {
                practicePageBloc.add(PracticePageNextQuestion());
              }
            case LoadedPracticePageState(status: ChapterPageStatus.incorrect):
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
            case LoadedPracticePageState(status: ChapterPageStatus.finishedWithAllQuestions):
              context.read<UserDataBloc>().add(
                PracticeChapterCompletedUserDataEvent(
                  lessonId: practicePageBloc.state.lesson.id,
                  chapterIndex: practicePageBloc.state.chapterIndex,
                ),
              );
            case _:
              return;
          }
        },
        child: Builder(
          builder: (context) {
            if (practicePageBloc.state is! LoadedPracticePageState) {
              return const Material(child: Center(child: CircularProgressIndicator()));
            }

            return MultiProvider(
              providers: [
                BlocProvider.value(value: practicePageBloc),

                ///   by the different widgets in the tree.
                InheritedProvider(
                  create: (_) => HSLColor.fromColor(practicePageBloc.state.lesson.color),
                ),
              ],
              child: PracticePageView(),
            );
          },
        ),
      ),
    );
  }
}

class PracticePageView extends StatefulWidget {
  const PracticePageView({super.key});

  @override
  State<PracticePageView> createState() => _PracticePageViewState();
}

class _PracticePageViewState extends State<PracticePageView> {
  late final GlobalKey progressBarKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var state = context.select(
      (PracticePageBloc bloc) => bloc.state as LoadedPracticePageState,
    );

    if (state.status == ChapterPageStatus.finishedWithAllQuestions) {
      return CompletedPracticeBody(progressBarKey: progressBarKey);
    }
    return PracticeBody(progressBarKey: progressBarKey);
  }
}
