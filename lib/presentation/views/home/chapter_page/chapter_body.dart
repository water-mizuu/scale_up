import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/ChapterPageBloc/chapter_page_bloc.dart";
import "package:scale_up/presentation/bloc/ChapterPageBloc/chapter_page_event.dart";
import "package:scale_up/presentation/bloc/ChapterPageBloc/chapter_page_state.dart";
import "package:scale_up/presentation/views/home/chapter_page/calculator.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class ChapterBody extends StatelessWidget {
  const ChapterBody({super.key});

  @override
  Widget build(BuildContext context) {
    var chapterPageBloc = context.read<ChapterPageBloc>();
    var state = chapterPageBloc.state as LoadedChapterPageState;
    var LoadedChapterPageState(:questions, :questionIndex) = state;
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Styles.title("Question ${questionIndex + 1}", textAlign: TextAlign.left),
                  Styles.subtitle(
                    "Convert the unit from ${left.name} to ${right.name}",
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.w400,
                  ),
                  Expanded(
                    child: Center(
                      child: Styles.title(
                        "$number ${left.shortcut} to ___ ${right.shortcut}?",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: BlocBuilder<ChapterPageBloc, ChapterPageState>(
                buildWhen: (p, n) => p.status == ChapterPageStatus.movingToNextQuestion,
                builder: (_, _) {
                  return CalculatorWidget(
                    onEvaluate: (expression) {
                      chapterPageBloc.add(ChapterPageInputChanged(expression));
                    },
                  );
                },
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
