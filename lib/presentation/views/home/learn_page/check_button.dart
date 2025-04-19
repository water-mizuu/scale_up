import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/LearnPage/learn_page_bloc.dart";

class CheckButton extends StatelessWidget {
  const CheckButton({super.key});

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
            state.status == LearnPageStatus.correct ||
            state.status == LearnPageStatus.incorrect;

        return FilledButton(
          style: FilledButton.styleFrom(backgroundColor: buttonColor),
          onPressed:
              // Disable the button if the status is correct, or if there is no answer.
              learnPageBloc.loadedState.answer == null
                  ? null
                  : hasAnswered
                  ? () {
                    learnPageBloc.add(LearnPageNextQuestionClickedEvent());
                  }
                  : () {
                    learnPageBloc.add(LearnPageAnswerSubmittedEvent());
                  },
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
