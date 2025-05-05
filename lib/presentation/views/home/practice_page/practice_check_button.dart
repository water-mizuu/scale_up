import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_event.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_state.dart";

class PracticeCheckButton extends StatelessWidget {
  const PracticeCheckButton({super.key});

  @override
  Widget build(BuildContext context) {
    var chapterPageBloc = context.watch<PracticePageBloc>();
    var state = chapterPageBloc.loadedState;
    var hslColor = chapterPageBloc.loadedState.lesson.hslColor;
    var buttonColor =
        hslColor //
            .withHue((hslColor.hue + 180) % 360)
            .withSaturation((hslColor.saturation * 0.5).clamp(0, 1))
            .withLightness(0.35)
            .toColor();

    var hasAnswered =
        state.status == PracticePageStatus.correct || //
        state.status == PracticePageStatus.incorrect;

    var isFinished = chapterPageBloc.loadedState.status == PracticePageStatus.finished;

    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      onPressed: () {
        if (hasAnswered) {
          return () {
            HapticFeedback.selectionClick();

            chapterPageBloc.add(const PracticePageNextQuestionClicked());
          };
        }

        if (chapterPageBloc.loadedState.status == PracticePageStatus.waitingForSubmission &&
            chapterPageBloc.loadedState.answer != null) {
          return () {
            HapticFeedback.selectionClick();
            chapterPageBloc.add(const PracticePageAnswerSubmitted());
          };
        }

        if (isFinished) {
          return () {
            HapticFeedback.selectionClick();
            chapterPageBloc.add(const PracticePageReturnToLessonClicked());
          };
        }
      }(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(() {
          if (hasAnswered || isFinished) {
            return "Continue";
          }
          return "Check";
        }(), style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
