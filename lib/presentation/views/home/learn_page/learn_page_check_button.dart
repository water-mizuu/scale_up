import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/LearnPage/learn_page_bloc.dart";

class LearnPageCheckButton extends StatelessWidget {
  const LearnPageCheckButton({super.key});

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

    return BlocBuilder<LearnPageBloc, LearnPageState>(
      builder: (context, state) {
        var hasAnswered =
            state.status == LearnPageStatus.correct || //
            state.status == LearnPageStatus.incorrect;

        return FilledButton(
          style: FilledButton.styleFrom(backgroundColor: buttonColor),
          onPressed: () {
            if (hasAnswered) {
              return () => learnPageBloc.add(LearnPageNextQuestionClickedEvent());
            }

            if (learnPageBloc.loadedState.status == LearnPageStatus.waitingForSubmission &&
                learnPageBloc.loadedState.answer != null) {
              return () => learnPageBloc.add(LearnPageAnswerSubmittedEvent());
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
