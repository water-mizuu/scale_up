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
    var chapterPageBloc = context.read<PracticePageBloc>();
    var hslColor = chapterPageBloc.loadedState.lesson.hslColor;
    var buttonColor =
        hslColor //
            .withHue((hslColor.hue + 180) % 360)
            .withSaturation((hslColor.saturation * 0.5).clamp(0, 1))
            .withLightness(0.35)
            .toColor();

    return BlocBuilder<PracticePageBloc, PracticePageState>(
      builder: (context, state) {
        var hasAnswered =
            state.status == PracticePageStatus.correct || //
            state.status == PracticePageStatus.incorrect;

        var isFinished = chapterPageBloc.loadedState.status == PracticePageStatus.finished;

        return FilledButton(
          style: FilledButton.styleFrom(backgroundColor: buttonColor),
          onPressed: () {
            if (hasAnswered) {
              return () {
                HapticFeedback.selectionClick();

                chapterPageBloc.add(PracticePageNextQuestionClicked());
              };
            }

            if (chapterPageBloc.loadedState.status == PracticePageStatus.waitingForSubmission &&
                chapterPageBloc.loadedState.answer != null) {
              return () {
                HapticFeedback.selectionClick();
                chapterPageBloc.add(PracticePageAnswerSubmitted());
              };
            }

            if (isFinished) {
              return () {
                HapticFeedback.selectionClick();
                chapterPageBloc.add(PracticePageReturnToLessonClicked());
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
      },
    );
  }
}
