import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
// import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/single_child_widget.dart";
import "package:scale_up/data/models/unit.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/numerical_expression.dart";
import "package:scale_up/hooks/use_animated_scroll_controller.dart";
import "package:scale_up/presentation/bloc/indirect_steps/indirect_steps_cubit.dart";
import "package:scale_up/presentation/bloc/indirect_steps/indirect_steps_state.dart";
import "package:scale_up/presentation/bloc/learn_page/learn_page_bloc.dart";
import "package:scale_up/presentation/views/home/learn_page/"
    "learn_choices/blank_choice_unit_tile.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_choices/choice_unit_tile.dart";
import "package:scale_up/presentation/views/home/widgets/floating_card.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/extensions/num_duration_extension.dart";
import "package:scale_up/utils/widgets/animated_slide_transition.dart";
import "package:scale_up/utils/widgets/tool_tip.dart";

class LearnInstructions extends StatelessWidget {
  const LearnInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    var currentQuestion = context.select(
      (LearnPageBloc b) => b.loadedState.questions[b.loadedState.questionIndex],
    );

    switch (currentQuestion) {
      case PlainLearnQuestion():
        return PlainLearnInstructions(currentQuestion: currentQuestion);
      case DirectFormulaLearnQuestion():
        return DirectFormulaInstructions(currentQuestion: currentQuestion);
      case ImportantNumbersLearnQuestion():
        return ImportantNumbersInstructions(currentQuestion: currentQuestion);
      case IndirectStepsLearnQuestion():
        return IndirectStepsInstructions(currentQuestion: currentQuestion);
      case PracticeConversionLearnQuestion():
        return PracticeConversionInstructions(currentQuestion: currentQuestion);
    }
  }
}

// LearnQuestion.plainLearn
class PlainLearnInstructions extends HookWidget {
  const PlainLearnInstructions({super.key, required this.currentQuestion});

  final PlainLearnQuestion currentQuestion;

  @override
  Widget build(BuildContext context) {
    var scrollController = useAnimatedScrollController();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: _AnimatedQuestionPanel(
        isRetry: false,
        hint: "Read the lesson:",
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [for (var child in currentQuestion.children) child],
          ),
        ),
      ),
    );
  }
}

// LearnQuestion.directFormula
class DirectFormulaInstructions extends StatelessWidget {
  const DirectFormulaInstructions({super.key, required this.currentQuestion});

  final DirectFormulaLearnQuestion currentQuestion;

  @override
  Widget build(BuildContext context) {
    var DirectFormulaLearnQuestion(:from, :to, :answer, :isRetry) = currentQuestion;

    return _AnimatedQuestionPanel(
      isRetry: isRetry,
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Styles.subtitle("How would you convert from "),
          ToolTip(
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
                        const TextSpan(text: " = "),
                        TextSpan(text: answer.substituteString("from", from.shortcut).str),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            child: Text.rich(
              TextSpan(
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dashed,
                ),
                children: [
                  TextSpan(
                    text: "${from.name} (${from.shortcut})",
                    style: Styles.subtitle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: " to ", style: Styles.subtitle),
                  TextSpan(
                    text: "${to.name} (${to.shortcut})",
                    style: Styles.subtitle.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
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
    var ImportantNumbersLearnQuestion(:from, :to, :answer, :isRetry) = currentQuestion;

    return _AnimatedQuestionPanel(
      isRetry: isRetry,
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
            child: Text.rich(
              style: const TextStyle(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed,
              ),
              TextSpan(
                children: [
                  if (answer.length == 1)
                    const TextSpan(text: "number", style: Styles.subtitle)
                  else
                    const TextSpan(text: "numbers", style: Styles.subtitle),
                ],
              ),
            ),
          ),
          Styles.subtitle(" used when converting from "),
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

// LearnQuestion.indirectSteps
class IndirectStepsInstructions extends HookWidget {
  const IndirectStepsInstructions({super.key, required this.currentQuestion});

  final IndirectStepsLearnQuestion currentQuestion;

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 32.0,
      children: [IndirectStepsQuestionPanel(), IndirectStepsAnswerSpots()],
    );
  }
}

class IndirectStepsQuestionPanel extends HookWidget {
  const IndirectStepsQuestionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    var IndirectStepsLearnQuestion(:from, :to, :steps, :isRetry) = context.select(
      (IndirectStepsCubit c) => c.activeState.question,
    );

    return _AnimatedQuestionPanel(
      isRetry: isRetry,
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Styles.subtitle("How would you convert from "),
          ToolTip(
            content: IndirectStepsToolTipContent(steps: steps),
            child: Text.rich(
              TextSpan(
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dashed,
                ),
                children: [
                  TextSpan(
                    text: "${from.name} (${from.shortcut})",
                    style: Styles.subtitle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: " to ", style: Styles.subtitle),
                  TextSpan(
                    text: "${to.name} (${to.shortcut})",
                    style: Styles.subtitle.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Styles.subtitle(" without a direct formula?"),
        ],
      ),
    );
  }
}

class IndirectStepsAnswerSpots extends HookWidget {
  const IndirectStepsAnswerSpots({super.key});

  @override
  Widget build(BuildContext context) {
    var answerKeys = context.select((IndirectStepsCubit c) => c.activeState.answerKeys);
    var steps = context.select((IndirectStepsCubit c) => c.activeState.question.steps);

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
                padding: const EdgeInsets.symmetric(vertical: 12.0),
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

              Padding(padding: const EdgeInsets.only(left: 4.0), child: Styles.subtitle(".")),
            ],
          ),
      ],
    );

    return AnimatedSlideTransition(delay: 120.ms, child: child);
  }
}

class AnswerTile extends StatelessWidget {
  const AnswerTile({super.key, required this.index, required this.unit});

  final int index;
  final Unit unit;

  @override
  Widget build(BuildContext context) {
    var state = context.select((IndirectStepsCubit c) => c.state);
    if (state is! ActiveIndirectStepsState) {
      if (kDebugMode) {
        print("AnswerTile: state is not active indirect steps state");
      }

      return const SizedBox.shrink();
    }

    if (state.answers[index] case (_, var unit)?) {
      return ChoiceUnitTile(
        unit: unit,
        onTap: () {
          HapticFeedback.selectionClick();

          context.read<IndirectStepsCubit>().putBack(index);
        },
      );
    } else {
      return BlankChoiceUnitTile(unit: unit);
    }
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
                  const TextSpan(text: " From "),
                  TextSpan(
                    text: from.shortcut,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: " to "),
                  TextSpan(
                    text: to.shortcut,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ":"),
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

class PracticeConversionInstructions extends HookWidget {
  const PracticeConversionInstructions({super.key, required this.currentQuestion});

  final PracticeConversionLearnQuestion currentQuestion;

  @override
  Widget build(BuildContext context) {
    var PracticeConversionLearnQuestion(:from, :to, :question, :path, :isRetry) = currentQuestion;

    return _AnimatedQuestionPanel(
      isRetry: isRetry,
      hint: "Try it yourself:",
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            runAlignment: WrapAlignment.center,
            children: [
              Styles.subtitle("Convert the unit from "),
              Styles.subtitle("${from.name} ", fontWeight: FontWeight.bold),
              Styles.subtitle(
                "(${from.shortcut})",
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.notoSansMath().fontFamily,
              ),
              Styles.subtitle(" to "),
              Styles.subtitle("${to.name} ", fontWeight: FontWeight.bold),
              Styles.subtitle(
                "(${to.shortcut})",
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.notoSansMath().fontFamily,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Center(
              child: ToolTip(
                content: IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Styles.subtitle("Conversion steps"),

                      /// IntrinsicHeight tells the Row to take the height of the tallest child,
                      ///   and impose that as a Constraint on the entire widget.
                      for (var (i, ((from, to), expr)) in path.indexed) ...[
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: "${i + 1}."),
                              const TextSpan(text: " From "),
                              TextSpan(
                                text: from.shortcut,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const TextSpan(text: " to "),
                              TextSpan(
                                text: to.shortcut,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const TextSpan(text: ":"),
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
                ),
                child: Container(
                  /// There should be an underline under the text.
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Styles.title(
                    "$question ${from.shortcut} to ___ ${to.shortcut}?",
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dashed,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedQuestionPanel extends SingleChildStatelessWidget {
  const _AnimatedQuestionPanel({
    required Widget super.child,
    required this.isRetry,
    this.hint = "Answer the question: ",
  });

  final String hint;
  final bool isRetry;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AnimatedSlideTransition(
      child: FloatingCardWithHint(hint: hint, isRetry: isRetry, child: child!),
    );
  }
}
