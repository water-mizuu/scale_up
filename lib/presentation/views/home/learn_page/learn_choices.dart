import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/models/unit.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/numerical_expression.dart";
import "package:scale_up/presentation/bloc/IndirectSteps/indirect_steps_cubit.dart";
import "package:scale_up/presentation/bloc/IndirectSteps/indirect_steps_state.dart";
import "package:scale_up/presentation/bloc/LearnPage/learn_page_bloc.dart";
import "package:scale_up/presentation/views/home/learn_page/bordered_widget.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/animation_controller_distinction.dart";
import "package:scale_up/utils/extensions/hsl_color_scheme_extension.dart";

class LearnChoices extends StatelessWidget {
  const LearnChoices({super.key});

  @override
  Widget build(BuildContext context) {
    var currentQuestion = context.select(
      (LearnPageBloc b) => b.loadedState.questions[b.loadedState.questionIndex],
    );

    switch (currentQuestion) {
      case PlainLearnQuestion():
        return const SizedBox.shrink();
      case DirectFormulaLearnQuestion():
        return DirectFormulaChoices(currentQuestion: currentQuestion);
      case ImportantNumbersLearnQuestion():
        return ImportantNumbersChoices(currentQuestion: currentQuestion);
      case IndirectStepsLearnQuestion():
        return IndirectStepsChoices(currentQuestion: currentQuestion);
    }
  }
}

// LearnQuestion.directFormula
class DirectFormulaChoices extends StatelessWidget {
  const DirectFormulaChoices({super.key, required this.currentQuestion});

  final DirectFormulaLearnQuestion currentQuestion;

  @override
  Widget build(BuildContext context) {
    var DirectFormulaLearnQuestion(:choices) = currentQuestion;

    return Column(
      spacing: 24.0,
      children: [
        Column(
          spacing: 12.0,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var (i, choice) in choices.indexed)
              DirectFormulaChoice(choice: choice, currentQuestion: currentQuestion)
                  .animate(
                    controller: context.read<TransitionOutAnimationController>().controller,
                    autoPlay: false,
                  )
                  .then(delay: (i * 100).ms)
                  .slideX(begin: 0.0, end: -0.25, curve: Curves.easeInOut)
                  .fadeOut()
                  .animate(
                    controller: context.read<TransitionInAnimationController>().controller,
                    autoPlay: false,
                  )
                  .then(delay: (i * 100).ms)
                  .slideX(begin: 0.25, end: 0.0, curve: Curves.easeInOut)
                  .fadeIn(),
          ],
        ),

        Styles.hint("Choose your answer here!", textAlign: TextAlign.center),
      ],
    );
  }
}

class DirectFormulaChoice extends StatelessWidget {
  const DirectFormulaChoice({super.key, required this.choice, required this.currentQuestion});

  final NumericalExpression choice;
  final DirectFormulaLearnQuestion currentQuestion;

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(8.0);
    var DirectFormulaLearnQuestion(:from, :to, :comparison) = currentQuestion;
    var learnPageBloc = context.watch<LearnPageBloc>();
    var hslColor = learnPageBloc.loadedState.lesson.hslColor;
    var answer = learnPageBloc.loadedState.answer;

    Widget widget = Material(
      child: ListTile(
        onTap: () {
          if (learnPageBloc.state.status == LearnPageStatus.waitingForSubmission) {
            return () {
              HapticFeedback.selectionClick();
              learnPageBloc.add(LearnPageAnswerUpdated.directFormula(answer: choice));
            };
          }
          return null;
        }(),
        tileColor: hslColor.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: BorderSide(color: hslColor.borderColor),
        ),
        title: Text(
          "${to.shortcut} = ${choice.substituteString("from", from.shortcut)}",
          style: GoogleFonts.notoSansMath(),
        ),
      ),
    );

    var isBordered = false;
    if (learnPageBloc.loadedState.status == LearnPageStatus.correct ||
        learnPageBloc.loadedState.status == LearnPageStatus.incorrect) {
      var LoadedLearnPageState(:correctAnswer, :answer) = learnPageBloc.loadedState;

      /// If the answer is correct, highlight it.
      if (comparison(choice, correctAnswer)) {
        widget = CorrectWidget(child: widget);
        isBordered = true;
      } else if (comparison(choice, answer) && !comparison(choice, correctAnswer)) {
        widget = IncorrectWidget(widget: widget);
        isBordered = true;
      }
    } else if (comparison(choice, answer)) {
      widget = SelectedWidget(child: widget);
      isBordered = true;
    }

    if (!isBordered) {
      widget = UnselectedWidget(child: widget);
    }

    return widget;
  }
}

// LearnQuestion.importantNumbers
class ImportantNumbersChoices extends StatelessWidget {
  const ImportantNumbersChoices({super.key, required this.currentQuestion});

  final ImportantNumbersLearnQuestion currentQuestion;

  @override
  Widget build(BuildContext context) {
    var ImportantNumbersLearnQuestion(:choices) = currentQuestion;

    return Column(
      spacing: 24.0,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          spacing: 12.0,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var (i, choice) in choices.indexed)
              ImportantNumbersChoice(choice: choice, currentQuestion: currentQuestion)
                  .animate(
                    controller: context.read<TransitionOutAnimationController>().controller,
                    autoPlay: false,
                  )
                  .then(delay: (i * 100).ms)
                  .slideX(begin: 0.0, end: -0.25, curve: Curves.easeInOut)
                  .fadeOut()
                  .animate(
                    controller: context.read<TransitionInAnimationController>().controller,
                    autoPlay: false,
                  )
                  .then(delay: (i * 100).ms)
                  .slideX(begin: 0.25, end: 0.0, curve: Curves.easeInOut)
                  .fadeIn(),
          ],
        ),
        Styles.hint("Choose your answer here!", textAlign: TextAlign.center),
      ],
    );
  }
}

class ImportantNumbersChoice extends StatelessWidget {
  const ImportantNumbersChoice({super.key, required this.choice, required this.currentQuestion});

  final Set<num> choice;
  final ImportantNumbersLearnQuestion currentQuestion;

  @override
  Widget build(BuildContext context) {
    var ImportantNumbersLearnQuestion(:comparison) = currentQuestion;
    var learnPageBloc = context.watch<LearnPageBloc>();
    var hslColor = learnPageBloc.loadedState.lesson.hslColor;
    var answer = learnPageBloc.loadedState.answer;
    var backgroundColor =
        hslColor //
            .withSaturation(hslColor.saturation * 0.8)
            .withLightness(0.95)
            .toColor();
    var borderColor =
        hslColor //
            .withSaturation(hslColor.saturation * 0.8)
            .withLightness(0.80)
            .toColor();

    Widget widget = Material(
      borderRadius: BorderRadius.circular(8.0),
      borderOnForeground: true,
      color: backgroundColor,
      child: ListTile(
        onTap: () {
          if (learnPageBloc.state.status == LearnPageStatus.waitingForSubmission) {
            return () {
              HapticFeedback.selectionClick();
              learnPageBloc.add(LearnPageAnswerUpdated.importantNumbers(answer: choice));
            };
          }
          return null;
        }(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: borderColor),
        ),
        title: Text(choice.join(", "), style: GoogleFonts.notoSansMath()),
      ),
    );

    var isBordered = false;
    if (learnPageBloc.loadedState.status == LearnPageStatus.correct ||
        learnPageBloc.loadedState.status == LearnPageStatus.incorrect) {
      var LoadedLearnPageState(:correctAnswer, :answer) = learnPageBloc.loadedState;

      /// If the answer is correct, highlight it.
      if (comparison(choice, correctAnswer)) {
        widget = CorrectWidget(child: widget);
        isBordered = true;
      } else if (comparison(choice, answer) && !comparison(choice, correctAnswer)) {
        widget = IncorrectWidget(widget: widget);
        isBordered = true;
      }
    } else if (comparison(choice, answer)) {
      widget = SelectedWidget(child: widget);
      isBordered = true;
    }

    if (!isBordered) {
      widget = UnselectedWidget(child: widget);
    }

    return widget;
  }
}

class IndirectStepsChoices extends StatelessWidget {
  const IndirectStepsChoices({super.key, required this.currentQuestion});

  final IndirectStepsLearnQuestion currentQuestion;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24.0,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
              spacing: 12.0,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              runSpacing: 12.0,
              children: [
                for (var (i, choice) in currentQuestion.choices.indexed)
                  IndirectStepsChoice(index: i, unit: choice),
              ],
            )
            .animate(
              controller: context.read<TransitionOutAnimationController>().controller,
              autoPlay: false,
            )
            /// WARNING: This should not be changed. I don't know why,
            ///   but without this delay, the animation throws.
            ///  I have NOT yet found the reason.
            .then(delay: 120.ms)
            .slideX(begin: 0.0, end: -0.5, curve: Curves.easeInOut)
            .fadeOut()
            .animate(
              controller: context.read<TransitionInAnimationController>().controller,
              autoPlay: false,
            )
            .slideX(begin: 0.25, end: 0.0, curve: Curves.easeInOut)
            .fadeIn(), //
        Styles.hint("Tap the units in sequence!", textAlign: TextAlign.center),
      ],
    );
  }
}

final padding = EdgeInsets.all(8.0) + EdgeInsets.symmetric(horizontal: 8.0);
final borderRadius = BorderRadius.circular(8.0);

class IndirectStepsChoice extends StatelessWidget {
  const IndirectStepsChoice({super.key, required this.index, required this.unit});

  final int index;
  final Unit unit;

  @override
  Widget build(BuildContext context) {
    var (key, stateUnit, isAnimating) = context.select(
      (IndirectStepsCubit c) => (
        c.state.choiceKeys[index],
        c.state.choices[index],
        c.state.status == IndirectStepsStatus.animating,
      ),
    );

    /// If the stateUnit is null, it means that the user has selected this unit.
    if (stateUnit == null) {
      return BlankChoiceUnitTile(key: key, unit: unit);
    }

    return ChoiceUnitTile(
      key: key,
      unit: unit,
      onTap: () {
        if (isAnimating) {
          return null;
        }

        return () {
          HapticFeedback.selectionClick();

          context.read<IndirectStepsCubit>().answer(index);
        };
      }(),
    );
  }
}

class ChoiceUnitTile extends StatelessWidget {
  const ChoiceUnitTile({super.key, required this.unit, this.onTap});

  final Unit unit;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var hslColor = context.read<LearnPageBloc>().loadedState.lesson.hslColor;
    var backgroundColor =
        hslColor //
            .withSaturation(hslColor.saturation * 0.8)
            .withLightness(0.95)
            .toColor();

    var borderColor =
        hslColor //
            .withSaturation(hslColor.saturation * 0.8)
            .withLightness(0.75)
            .toColor();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
          border: Border.all(color: borderColor),
        ),
        padding: padding,
        child: Text(unit.shortcut, style: GoogleFonts.notoSansMath()),
        //
      ),
    );
  }
}

class BlankChoiceUnitTile extends StatelessWidget {
  const BlankChoiceUnitTile({super.key, required this.unit});

  final Unit unit;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: borderRadius,
          border: Border.all(color: Colors.grey[200]!.borderColor),
        ),
        padding: EdgeInsets.all(8.0) + EdgeInsets.symmetric(horizontal: 8.0),
        child: Opacity(
          opacity: 0.0,
          child: Text(unit.shortcut, style: GoogleFonts.notoSansMath()),
        ),
      ),
    );
  }
}
