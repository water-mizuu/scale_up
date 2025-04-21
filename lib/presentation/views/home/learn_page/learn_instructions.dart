import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";
import "package:scale_up/presentation/bloc/LearnPage/learn_page_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/box_shadow.dart";
import "package:scale_up/presentation/views/home/widgets/dotted_underline.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/animation_controller_distinction.dart";
import "package:super_tooltip/super_tooltip.dart";

class LearnInstructions extends StatelessWidget {
  const LearnInstructions({super.key});

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
        return ImportantNumbersLearnInstructions(currentQuestion: currentQuestion);
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

    return _QuestionPanel(
      child: Wrap(
        children: [
          Styles.subtitle("How would you convert from "),
          DottedUnderline(
            dashPattern: [4, 4],
            child: SuperTooltip(
              content: IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Styles.subtitle("Conversion formula:", fontWeight: FontWeight.w600),
                    Text.rich(
                      TextSpan(
                        style: GoogleFonts.notoSansMath(),
                        children: [
                          TextSpan(text: to.shortcut),
                          TextSpan(text: " = "),
                          TextSpan(text: answer.substituteString("from", from.shortcut).str),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${from.name} (${from.shortcut})",
                      style: Styles.subtitle.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: " to ", style: Styles.subtitle),
                    TextSpan(
                      text: "${to.name} (${to.shortcut})",
                      style: Styles.subtitle.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Styles.subtitle("?"),
        ],
      ),
    );
  }
}

// LearnQuestion.importantNumbers
class ImportantNumbersLearnInstructions extends StatelessWidget {
  const ImportantNumbersLearnInstructions({super.key, required this.currentQuestion});

  final ImportantNumbersLearnQuestion currentQuestion;

  @override
  Widget build(BuildContext context) {
    var ImportantNumbersLearnQuestion(:from, :to, :answer) = currentQuestion;

    return _QuestionPanel(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (answer.length == 1)
            Styles.subtitle("What is the ")
          else
            Styles.subtitle("What are the "),
          SuperTooltip(
            content: IntrinsicWidth(child: Styles.subtitle(answer.join(", "))),
            child: DottedUnderline(
              dashPattern: [4, 4],
              stackFit: StackFit.passthrough,
              child: Text.rich(
                TextSpan(
                  children: [
                    if (answer.length == 1)
                      TextSpan(text: "number", style: Styles.subtitle)
                    else
                      TextSpan(text: "numbers", style: Styles.subtitle),
                  ],
                ),
              ),
            ),
          ),
          Styles.subtitle("used when converting from "),
          Styles.subtitle("${from.name} (${from.shortcut})", fontWeight: FontWeight.bold),
          Styles.subtitle(" to "),
          Styles.subtitle("${to.name} (${to.shortcut})", fontWeight: FontWeight.bold),
          Styles.subtitle(" or "),
          Styles.subtitle("vice versa?"),
        ],
      ),
    );
  }
}

class _QuestionPanel extends StatelessWidget {
  const _QuestionPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var widget = Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: defaultBoxShadow,
      ),
      child: Column(
        spacing: 12.0,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [Styles.hint("Answer the question:"), child],
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
