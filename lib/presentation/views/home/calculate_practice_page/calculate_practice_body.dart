import "package:flutter/material.dart";
import "package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_event.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_state.dart";
import "package:scale_up/presentation/views/home/calculate_practice_page/calculator.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class CalculatePracticeBody extends StatelessWidget {
  const CalculatePracticeBody({required this.progressBarKey, super.key});

  final GlobalKey progressBarKey;

  @override
  Widget build(BuildContext context) {
    var chapterPageBloc = context.read<PracticePageBloc>();
    var state = chapterPageBloc.state as LoadedChapterPageState;
    var LoadedChapterPageState(:questions, :questionIndex) = state;
    var (left, right, number, _) = questions[questionIndex];

    return Padding(
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
                if (chapterPageBloc.state.progress case var progress?)
                  Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: FAProgressBar(
                      key: progressBarKey,
                      backgroundColor: Colors.white,
                      currentValue: progress * 100,
                      animatedDuration: const Duration(milliseconds: 150),
                    ),
                  ),
                const SizedBox(height: 12.0),
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
            child: BlocBuilder<PracticePageBloc, PracticePageState>(
              buildWhen: (p, n) => p.status == ChapterPageStatus.movingToNextQuestion,
              builder: (_, _) {
                return CalculatorWidget(
                  onEvaluate: (expression) {
                    chapterPageBloc.add(PracticePageInputChanged(expression));
                  },
                );
              },
            ),
          ),
          BlocBuilder<PracticePageBloc, PracticePageState>(
            builder: (context, state) {
              return FilledButton(
                onPressed:
                    state.status == ChapterPageStatus.correct
                        ? null
                        : () {
                          chapterPageBloc.add(PracticePageAnswerSubmitted());
                        },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text("Submit", style: TextStyle(fontSize: 16.0)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
