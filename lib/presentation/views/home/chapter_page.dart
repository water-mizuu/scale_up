import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/chapter.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/bloc/ChapterPageBloc/chapter_page_bloc.dart";
import "package:scale_up/presentation/bloc/ChapterPageBloc/chapter_page_event.dart";
import "package:scale_up/presentation/bloc/ChapterPageBloc/chapter_page_state.dart";
import "package:scale_up/presentation/bloc/UserData/user_data_bloc.dart";
import "package:scale_up/presentation/views/home/chapter_page/chapter_body.dart";
import "package:scale_up/presentation/views/home/chapter_page/chapter_description.dart";
import "package:scale_up/utils/snackbar_util.dart";

/// We assume that each instance of the ChapterPage is a new set of questions.
class ChapterPage extends StatefulWidget {
  const ChapterPage({required this.lessonId, required this.chapterIndex, super.key});

  final String lessonId;
  final int chapterIndex;

  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  late final Future<Lesson?> lessonFuture;
  ChapterPageBloc? chapterPageBloc;

  @override
  void initState() {
    super.initState();

    lessonFuture = context.read<LessonsHelper>().getLesson(widget.lessonId);
    lessonFuture
        .then((lesson) {
          if (!context.mounted || lesson == null) return;

          setState(() {
            chapterPageBloc = ChapterPageBloc(
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
    chapterPageBloc?.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (chapterPageBloc) {
      case null:
        return const Material(child: Center(child: CircularProgressIndicator()));
      case var chapterPageBloc:
        return BlocListener<ChapterPageBloc, ChapterPageState>(
          bloc: chapterPageBloc,
          listener: (context, state) async {
            switch (state) {
              case LoadedChapterPageState(:var error?):
                await context.showBasicSnackbar(error);

              /// These are the cases in which the user has answered.
              case LoadedChapterPageState(status: ChapterPageStatus.correct):
                await context.showBasicSnackbar("Correct!");

                if (context.mounted) {
                  chapterPageBloc.add(ChapterPageNextQuestion());
                }
              case LoadedChapterPageState(status: ChapterPageStatus.incorrect):
                await context.showBasicSnackbar(
                  "Incorrect! The correct answer was: ${state.correctAnswer}",
                );

                if (context.mounted) {
                  chapterPageBloc.add(ChapterPageNextQuestion());
                }
              case LoadedChapterPageState(status: ChapterPageStatus.completed):
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

class ChapterPageView extends StatelessWidget {
  const ChapterPageView({required this.lesson, required this.chapterIndex, super.key});

  final Lesson lesson;
  final int chapterIndex;
  Chapter get chapter => lesson.chapters[chapterIndex];

  @override
  Widget build(BuildContext context) {
    var state = context.watch<ChapterPageBloc>().state as LoadedChapterPageState;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: lesson.color,
        foregroundColor: lesson.foregroundColor,
      ),
      body: InheritedProvider.value(
        value: (lesson, chapter, state.chapterIndex),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ChapterDescription(),
              if (state.status == ChapterPageStatus.completed)
                Text("Congrats! You done bro")
              else
                ChapterBody(),
            ],
          ),
        ),
      ),
    );
  }
}
