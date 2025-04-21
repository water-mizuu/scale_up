import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:provider/provider.dart";
import "package:scale_up/presentation/bloc/LearnPage/learn_page_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/animation_controller_distinction.dart";

class Instructions extends StatelessWidget {
  const Instructions({super.key});

  @override
  Widget build(BuildContext context) {
    var learnPageBloc = context.watch<LearnPageBloc>();
    var state = learnPageBloc.state;
    if (state is! LoadedLearnPageState) {
      return const SizedBox.shrink();
    }

    var currentQuestion = state.questions[state.questionIndex];
    switch (currentQuestion) {
      case DirectFormulaLearnQuestion():
        return DirectFormulaInstructions(currentQuestion: currentQuestion);
      case ImportantNumbersLearnQuestion():

        /// TODO: Implement this
        throw UnimplementedError();
      case IndirectStepsLearnQuestion():

        /// TODO: Implement this
        throw UnimplementedError();
    }
  }
}

// LearnQuestion.directFormula
class DirectFormulaInstructions extends StatelessWidget {
  const DirectFormulaInstructions({super.key, required this.currentQuestion});

  final DirectFormulaLearnQuestion currentQuestion;

  @override
  Widget build(BuildContext context) {
    var DirectFormulaLearnQuestion(:from, :to, :answer) = currentQuestion;

    var widget = Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: "How would you convert from ", style: Styles.subtitle),
                TextSpan(
                  text: "${from.name} (${from.shortcut})",
                  style: Styles.subtitle.copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: " to ", style: Styles.subtitle),
                TextSpan(
                  text: "${to.name} (${to.shortcut})",
                  style: Styles.subtitle.copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: "?", style: Styles.subtitle),
              ],
            ),
          ),
        ],
      ),
    );

    return widget
        .animate(
          controller: context.read<TransitionOutAnimationController>().controller,
          autoPlay: false,
        )
        .slideX(begin: 0.0, end: -0.5, curve: Curves.easeInOut)
        .fadeOut()
        .animate(
          controller: context.read<TransitionInAnimationController>().controller,
          autoPlay: false,
        )
        .slideX(begin: 0.5, end: 0.0, curve: Curves.easeInOut)
        .fadeIn();
  }
}
