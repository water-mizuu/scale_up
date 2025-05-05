import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/learn_page/learn_page_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/animation_controller_distinction.dart";

class CongratulatoryMessage extends StatelessWidget {
  const CongratulatoryMessage({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.read<LearnPageBloc>().loadedState;
    var status = context.select((LearnPageBloc b) => b.loadedState.status);
    var controller = context.read<MessageAnimationController>().controller;

    var widget = DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: Colors.grey.shade500),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (status == LearnPageStatus.correct) ...[
                  Styles.title("Correct!", color: Colors.green),
                  Styles.subtitle(
                    "You got it right!",
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ] else if (status == LearnPageStatus.incorrect) ...[
                  Styles.title("Oops!", color: Colors.red),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "The answer was ",
                          style: Styles.subtitle.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: state.questions[state.questionIndex].correctAnswerString,
                          style: Styles.subtitle.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0) - const EdgeInsets.only(top: 16.0),
            child: TickerMode(
              enabled: false,
              child: FilledButton(
                onPressed: null,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    "Check",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return widget
        .animate(controller: controller, autoPlay: false)
        .slideY(begin: 1.0, end: 0.0, curve: Curves.linearToEaseOut);
  }
}
