import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/learn_page/learn_page_bloc.dart";

class LearnCheckButton extends StatelessWidget {
  const LearnCheckButton({super.key});

  @override
  Widget build(BuildContext context) {
    var learnPageBloc = context.watch<LearnPageBloc>();
    var state = learnPageBloc.state;
    if (state is! LoadedLearnPageState) {
      return const SizedBox();
    }

    var hslColor = learnPageBloc.loadedState.lesson.hslColor;
    var buttonColor =
        hslColor //
            .withHue((hslColor.hue + 180) % 360)
            .withSaturation((hslColor.saturation * 0.5).clamp(0, 1))
            .withLightness(0.35)
            .toColor();

    var hasAnswered =
        state.status == LearnPageStatus.correct || //
        state.status == LearnPageStatus.incorrect;

    var isFinished = learnPageBloc.loadedState.status == LearnPageStatus.finished;
    var isPlain =
        learnPageBloc.loadedState.questions[learnPageBloc.loadedState.questionIndex]
            is PlainLearnQuestion;

    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: buttonColor),
      onPressed: () {
        if (hasAnswered || isPlain) {
          return () {
            HapticFeedback.selectionClick();

            learnPageBloc.add(LearnPageNextQuestionClicked());
          };
        }

        if (learnPageBloc.loadedState.status == LearnPageStatus.waitingForSubmission &&
            learnPageBloc.loadedState.answer != null) {
          return () {
            HapticFeedback.selectionClick();

            learnPageBloc.add(LearnPageAnswerSubmitted());
          };
        }

        if (isFinished) {
          return () {
            HapticFeedback.selectionClick();

            learnPageBloc.add(LearnPageReturnToLessonClicked());
          };
        }
      }(),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Text(() {
          if (hasAnswered || isFinished || isPlain) {
            return "Continue";
          }

          return "Check";
        }(), style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
