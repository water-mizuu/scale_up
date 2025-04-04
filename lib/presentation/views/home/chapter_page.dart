import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository/chapter.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository/lesson.dart";
import "package:scale_up/presentation/bloc/ChapterPageBloc/chapter_page_bloc.dart";
import "package:scale_up/presentation/bloc/ChapterPageBloc/chapter_page_event.dart";
import "package:scale_up/presentation/bloc/ChapterPageBloc/chapter_page_state.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

/// We assume that each instance of the ChapterPage is a new set of questions.
class ChapterPage extends StatelessWidget {
  const ChapterPage({
    required this.lessonFuture,
    required this.chapterIndex,
    super.key,
  });

  final Future<Lesson?> lessonFuture;
  final int chapterIndex;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => ChapterPageBloc(
            lessonsRepository: context.read(),
            lessonFuture: lessonFuture,
            chapterIndex: chapterIndex,
          ),
        ),
      ],
      builder: (context, _) {
        var chapterPageBloc = context.watch<ChapterPageBloc>();

        return BlocListener<ChapterPageBloc, ChapterPageState>(
          listener: (context, state) {
            if (state is FailureChapterPageState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error ?? "Unknown error"),
                ),
              );
            }

            if (state case LoadedChapterPageState(:var error?)) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error),
                ),
              );
            }

            if (state case LoadedChapterPageState(status: ChapterPageStatus.correct)) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                    SnackBar(
                      content: Text("Correct!"),
                    ),
                  )
                  .closed
                  .then((_) {
                chapterPageBloc.add(ChapterPageNextQuestion());
              });
            } else if (state case LoadedChapterPageState(status: ChapterPageStatus.incorrect)) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                    SnackBar(
                      content: Text("Incorrect!"),
                    ),
                  )
                  .closed
                  .then((_) {
                chapterPageBloc.add(ChapterPageNextQuestion());
              });
            }
          },
          child: switch (chapterPageBloc.state) {
            FailureChapterPageState() || InitialChapterPageState() => Material(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            LoadedChapterPageState state => ChapterPageView(
                lesson: state.lesson,
                chapterIndex: state.chapterIndex,
              )
          },
        );
      },
    );
  }
}

class ChapterPageView extends StatelessWidget {
  const ChapterPageView({
    required this.lesson,
    required this.chapterIndex,
    super.key,
  });

  final Lesson lesson;
  final int chapterIndex;
  Chapter get chapter => lesson.chapters[chapterIndex];

  @override
  Widget build(BuildContext context) {
    var (ChapterPageBloc(:state) && chapterPageBloc) = context.read();
    assert(state is LoadedChapterPageState, "State should be LoadedChapterPageState");
    var LoadedChapterPageState(
      questions: questions,
      questionIndex: index,
    ) = state as LoadedChapterPageState;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: lesson.color,
        foregroundColor: lesson.foregroundColor,
      ),
      body: InheritedProvider.value(
        value: (lesson, chapter),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ChapterDescription(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: Text("Index: $index")),
                  Row(children: [
                    if (questions[index] case (var left, var right, var number, var expr)) ...[
                      Text("$number ${left.shortcut} to ___ ${right.shortcut}?"),
                    ]
                  ]),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Answer (Round down)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: (value) {
                      chapterPageBloc.add(ChapterPageInputChanged(value));
                    },
                  ),
                  FilledButton(
                    onPressed: () {
                      chapterPageBloc.add(ChapterPageAnswerSubmitted());
                    },
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  )
                ],
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
    var (lesson, chapter) = context.read<(Lesson, Chapter)>();

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
          Styles.title(lesson.name, style: TextStyle(color: lesson.foregroundColor)),
          Styles.body(lesson.description, style: TextStyle(color: lesson.foregroundColor)),
          const SizedBox(height: 4.0),
        ],
      ),
    );
  }
}
