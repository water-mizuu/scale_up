import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/numerical_expression.dart";
import "package:scale_up/data/models/unit.dart";
import "package:scale_up/presentation/bloc/IndirectSteps/indirect_steps_cubit.dart";
import "package:scale_up/presentation/bloc/IndirectSteps/indirect_steps_state.dart";
import "package:scale_up/presentation/bloc/LearnPage/learn_page_bloc.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_choices.dart";
import "package:scale_up/presentation/views/home/widgets/dotted_underline.dart";
import "package:scale_up/presentation/views/home/widgets/floating_card.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/animation_controller_distinction.dart";
import "package:scale_up/utils/tool_tip.dart";

class LearnInstructions extends StatelessWidget {
  const LearnInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    var currentQuestion = context.select(
      (LearnPageBloc b) => b.loadedState.questions[b.loadedState.questionIndex],
    );

    switch (currentQuestion) {
      case DirectFormulaLearnQuestion():
        return DirectFormulaInstructions(currentQuestion: currentQuestion);
      case ImportantNumbersLearnQuestion():
        return ImportantNumbersInstructions(currentQuestion: currentQuestion);
      case IndirectStepsLearnQuestion():
        return IndirectStepsInstructions(currentQuestion: currentQuestion);
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

    return _AnimatedQuestionPanel(
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Styles.subtitle("How would you convert from "),
          DottedUnderline(
            dashPattern: [4, 4],
            child: ToolTip(
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
class ImportantNumbersInstructions extends StatelessWidget {
  const ImportantNumbersInstructions({super.key, required this.currentQuestion});

  final ImportantNumbersLearnQuestion currentQuestion;

  @override
  Widget build(BuildContext context) {
    var ImportantNumbersLearnQuestion(:from, :to, :answer) = currentQuestion;

    return _AnimatedQuestionPanel(
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (answer.length == 1)
            Styles.subtitle("What is the ")
          else
            Styles.subtitle("What are the "),
          ToolTip(
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

class IndirectStepsInstructions extends StatelessWidget {
  const IndirectStepsInstructions({super.key, required this.currentQuestion});

  final IndirectStepsLearnQuestion currentQuestion;

  @override
  Widget build(BuildContext context) {
    var answerKeys = context.read<IndirectStepsCubit>().state.answerKeys;
    var IndirectStepsLearnQuestion(:from, :to, :steps) =
        context.read<IndirectStepsCubit>().state.question;

    var child = Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        for (var (i, ((from, to), _)) in steps.indexed)
          TableRow(
            children: [
              if (i == 0)
                Styles.subtitle("First, convert ")
              else
                Styles.subtitle("Then, convert "),

              if (i == 0)
                Center(
                  child: Styles.subtitle(
                    from.shortcut,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.notoSansMath().fontFamily,
                  ),
                )
              else
                AnswerTile(key: answerKeys[2 * i - 1], index: 2 * i - 1, unit: from),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Styles.subtitle(" to "),
              ),

              if (i == steps.length - 1)
                Center(
                  child: Styles.subtitle(
                    to.shortcut,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.notoSansMath().fontFamily,
                  ),
                )
              else
                AnswerTile(key: answerKeys[2 * i], index: 2 * i, unit: from),

              Padding(padding: EdgeInsets.only(left: 4.0), child: Styles.subtitle(".")),
            ],
          ),
      ],
    );

    return Column(
      spacing: 32.0,
      children: [
        _AnimatedQuestionPanel(
          child: Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Styles.subtitle("How would you convert from "),
              DottedUnderline(
                dashPattern: [4, 4],
                child: ToolTip(
                  content: IndirectStepsToolTipContent(steps: steps),
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
              Styles.subtitle(" without a direct formula?"),
            ],
          ),
        ),

        child
            .animate(
              controller: context.read<TransitionOutAnimationController>().controller,
              autoPlay: false,
            )
            .then(delay: 120.milliseconds)
            .slideX(begin: 0.0, end: -0.5, curve: Curves.easeInOut)
            .fadeOut()
            .animate(
              controller: context.read<TransitionInAnimationController>().controller,
              autoPlay: false,
            )
            .then(delay: 120.milliseconds)
            .slideX(begin: 0.5, end: 0.0, curve: Curves.easeInOut)
            .fadeIn(),
      ],
    );
  }
}

class AnswerTile extends StatelessWidget {
  const AnswerTile({super.key, required this.index, required this.unit});

  final int index;
  final Unit unit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndirectStepsCubit, IndirectStepsState>(
      builder: (context, state) {
        if (state.answers[index] case (_, var unit)?) {
          return ChoiceUnitTile(
            unit: unit,
            onTap: () {
              context.read<IndirectStepsCubit>().putBack(index);
            },
          );
        } else {
          return BlankChoiceUnitTile(unit: unit);
        }
      },
    );
  }
}

class IndirectStepsToolTipContent extends StatelessWidget {
  const IndirectStepsToolTipContent({super.key, required this.steps});

  final List<((Unit, Unit), NumericalExpression)> steps;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Styles.subtitle("Conversion steps:", fontWeight: FontWeight.w600),
          for (var (i, ((from, to), expr)) in steps.indexed) ...[
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "${i + 1}."),
                  TextSpan(text: " From "),
                  TextSpan(text: from.shortcut, style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: " to "),
                  TextSpan(text: to.shortcut, style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ":"),
                ],
              ),
            ),

            Styles.body(
              "      "
              "${to.shortcut} = ${expr.substituteString("from", from.shortcut)}",
              textAlign: TextAlign.right,
            ),
          ],
        ],
      ),
    );
  }
}

class _AnimatedQuestionPanel extends StatelessWidget {
  const _AnimatedQuestionPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var widget = FloatingCardWithHint(hint: "Answer the question:", child: child);

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

class UnitTile extends StatelessWidget {
  const UnitTile({super.key, required this.unit});

  final Unit unit;

  @override
  Widget build(BuildContext context) {
    return Text(unit.shortcut, style: GoogleFonts.notoSansMath());
  }
}
