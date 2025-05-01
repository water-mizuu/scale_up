import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/LearnPage/learn_page_bloc.dart";

class LearnCheckButton extends StatelessWidget {
  const LearnCheckButton({super.key});

  @override
  Widget build(BuildContext context) {
    var learnPageBloc = context.watch<LearnPageBloc>();
    var hslColor = learnPageBloc.loadedState.lesson.hslColor;
    var buttonColor =
        hslColor //
            .withHue((hslColor.hue + 180) % 360)
            .withSaturation((hslColor.saturation * 0.5).clamp(0, 1))
            .withLightness(0.35)
            .toColor();

    var hasAnswered =
        learnPageBloc.state.status == LearnPageStatus.correct || //
        learnPageBloc.state.status == LearnPageStatus.incorrect;

    var isFinished = learnPageBloc.loadedState.status == LearnPageStatus.finished;

    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: buttonColor),
      onPressed: () {
        if (hasAnswered) {
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
          if (hasAnswered || isFinished) {
            return "Continue";
          }

          return "Check";
        }(), style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
