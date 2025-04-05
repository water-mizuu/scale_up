import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository/chapter.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository/lesson.dart";
import "package:scale_up/presentation/bloc/ChapterPageBloc/chapter_page_bloc.dart";
import "package:scale_up/presentation/bloc/ChapterPageBloc/chapter_page_event.dart";
import "package:scale_up/presentation/bloc/ChapterPageBloc/chapter_page_state.dart";
import "package:scale_up/presentation/views/home/chapter_page/calculator.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
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

  @override
  void initState() {
    super.initState();

    lessonFuture = context.read<LessonsRepository>().getLesson(widget.lessonId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: lessonFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          context.showBasicSnackbar(snapshot.error.toString());
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        assert(snapshot.hasData);

        return MultiProvider(
          providers: [
            BlocProvider(
              create:
                  (_) => ChapterPageBloc(
                    lessonsRepository: context.read(),
                    lesson: snapshot.data!,
                    chapterIndex: widget.chapterIndex,
                  ),
            ),
          ],
          builder: (context, _) {
            var chapterPageBloc = context.watch<ChapterPageBloc>();

            return BlocListener<ChapterPageBloc, ChapterPageState>(
              bloc: chapterPageBloc,
              listener: (context, state) async {
                switch (state) {
                  case FailureChapterPageState():
                    await context.showBasicSnackbar(state.error ?? "Unknown error");
                  case LoadedChapterPageState(:var error?):
                    await context.showBasicSnackbar(error);

                  /// These are the cases in which the user has answered.
                  case LoadedChapterPageState(status: ChapterPageStatus.correct):
                    await context.showBasicSnackbar("Correct!");

                    chapterPageBloc.add(ChapterPageNextQuestion());
                  case LoadedChapterPageState(
                    status: ChapterPageStatus.incorrect,
                    :var correctAnswer?,
                    //
                  ):
                    await context.showBasicSnackbar(
                      "Incorrect! The correct answer was: $correctAnswer",
                    );

                    chapterPageBloc.add(ChapterPageNextQuestion());
                  case _:
                    return;
                }
              },
              child: switch (chapterPageBloc.state) {
                FailureChapterPageState() || InitialChapterPageState() => Material(
                  child: const Center(child: CircularProgressIndicator()),
                ),
                LoadedChapterPageState state => ChapterPageView(
                  lesson: state.lesson,
                  chapterIndex: state.chapterIndex,
                ),
              },
            );
          },
        );
      },
    );
  }
}

class ChapterPageView extends StatelessWidget {
  const ChapterPageView({required this.lesson, required this.chapterIndex, super.key});

  final Lesson lesson;
  final int chapterIndex;
  Chapter get chapter => lesson.chapters[chapterIndex];

  @override
  Widget build(BuildContext context) {
    var (ChapterPageBloc(:state) && chapterPageBloc) = context.read();
    assert(state is LoadedChapterPageState, "State should be LoadedChapterPageState");

    var LoadedChapterPageState(:questions, :questionIndex) = state as LoadedChapterPageState;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: lesson.color,
        foregroundColor: lesson.foregroundColor,
      ),
      body: InheritedProvider(
        create: (_) => (lesson, chapter, questionIndex),
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

class ChapterBody extends StatelessWidget {
  const ChapterBody({super.key});

  @override
  Widget build(BuildContext context) {
    var (ChapterPageBloc(:state) && chapterPageBloc) = context.read();
    var LoadedChapterPageState(:questions, :questionIndex) = state as LoadedChapterPageState;
    var (left, right, number, _) = questions[questionIndex];

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          spacing: 8.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Styles.title("Question ${questionIndex + 1}"),
                  Styles.subtitle("Convert the unit from ${left.name} to ${right.name}"),
                  Row(children: [Text("$number ${left.shortcut} to ___ ${right.shortcut}?")]),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: CalculatorWidget(
                onEvaluate:
                    (v) => chapterPageBloc.add(ChapterPageInputChanged(v.toStringAsFixed(3))),
              ),
            ),
            FilledButton(
              onPressed: () {
                chapterPageBloc.add(ChapterPageAnswerSubmitted());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text("Submit", style: TextStyle(fontSize: 16.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChapterDescription extends StatelessWidget {
  const ChapterDescription({super.key});

  @override
  Widget build(BuildContext context) {
    var (lesson, chapter, index) = context.read<(Lesson, Chapter, int)>();

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: lesson.color,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        spacing: 4.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Styles.title(
            "${lesson.name} - Chapter ${index + 1}",
            style: TextStyle(color: lesson.foregroundColor),
          ),
          Styles.body(lesson.description, style: TextStyle(color: lesson.foregroundColor)),
          const SizedBox(height: 4.0),
        ],
      ),
    );
  }
}
