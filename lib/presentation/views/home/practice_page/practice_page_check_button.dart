import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_event.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_state.dart";

class PracticePageCheckButton extends StatelessWidget {
  const PracticePageCheckButton({super.key});

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

        return FilledButton(
          style: FilledButton.styleFrom(backgroundColor: buttonColor),
          onPressed: () {
            if (hasAnswered) {
              return () => chapterPageBloc.add(PracticePageNextQuestionClicked());
            }

            if (chapterPageBloc.loadedState.status == PracticePageStatus.waitingForSubmission &&
                chapterPageBloc.loadedState.answer != null) {
              return () => chapterPageBloc.add(PracticePageAnswerSubmitted());
            }
          }(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              hasAnswered ? "Continue" : "Check",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
            ),
          ),
        );
      },
    );
  }
}
