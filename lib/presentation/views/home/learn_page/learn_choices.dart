import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:functional_widget_annotation/functional_widget_annotation.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/numerical_expression.dart";
import "package:scale_up/presentation/bloc/learn_page/learn_page_bloc.dart";
import "package:scale_up/presentation/views/home/learn_page/bordered_widget.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_choices/indirect_steps_choice.dart";
import "package:scale_up/presentation/views/home/practice_page/calculator.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/animation_controller_distinction.dart";
import "package:scale_up/utils/extensions/hsl_color_scheme_extension.dart";

part "learn_choices.g.dart";

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
      case PracticeConversionLearnQuestion():
        return PracticeConversionChoices(currentQuestion: currentQuestion);
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
          var state = learnPageBloc.state;
          if (state is! LoadedLearnPageState) {
            return null;
          }

          if (state.status == LearnPageStatus.waitingForSubmission) {
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
          var state = learnPageBloc.state;
          if (state is! LoadedLearnPageState) {
            return null;
          }

          if (state.status == LearnPageStatus.waitingForSubmission) {
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
        ChoicesWrap(currentQuestion: currentQuestion)
            .animate(
              controller: context.read<TransitionOutAnimationController>().controller,
              autoPlay: false,
            )
            /// WARNING: This should not be changed. I don't know why,
            ///   but without this delay, the animation throws.
            ///  I have NOT yet found the reason.
            .then(delay: 200.ms)
            .slideX(begin: 0.0, end: -0.5, curve: Curves.easeInOut)
            .fadeOut()
            .animate(
              controller: context.read<TransitionInAnimationController>().controller,
              autoPlay: false,
            )
            /// WARNING: This should not be changed. I don't know why,
            ///   but without this delay, the animation throws.
            ///  I have NOT yet found the reason.
            .then(delay: 200.ms)
            .slideX(begin: 0.25, end: 0.0, curve: Curves.easeInOut)
            .fadeIn(), //
        Styles.hint("Tap the units in sequence!", textAlign: TextAlign.center),
      ],
    );
  }
}

class ChoicesWrap extends StatelessWidget {
  const ChoicesWrap({super.key, required this.currentQuestion});

  final IndirectStepsLearnQuestion currentQuestion;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        for (var (i, choice) in currentQuestion.choices.indexed)
          IndirectStepsChoice(index: i, unit: choice),
      ],
    );
  }
}

@hwidget
Widget practiceConversionChoices({required PracticeConversionLearnQuestion currentQuestion}) {
  var context = useContext();
  var learnPageBloc = context.watch<LearnPageBloc>();
  var hslColor = learnPageBloc.loadedState.lesson.hslColor;

  var widget = CalculatorWidget(
    hslColor: hslColor,
    onEvaluate: (expression) {
      try {
        var evaluated = expression.evaluate({});

        context.read<LearnPageBloc>().add(LearnPageAnswerUpdated(answer: evaluated));
      } on UnsupportedError {
        return;
      }
    },
  );

  return widget
      .animate(
        controller: context.read<TransitionOutAnimationController>().controller,
        autoPlay: false,
      )
      .then(delay: 200.ms)
      .slideX(begin: 0.0, end: -0.4, curve: Curves.easeOutQuad)
      .fadeOut()
      .animate(
        controller: context.read<TransitionInAnimationController>().controller,
        autoPlay: false,
      )
      .then(delay: 250.ms)
      .slideX(begin: 0.4, end: 0.0, curve: Curves.easeOutCubic)
      .fadeIn();
}

final padding = const EdgeInsets.all(8.0) + const EdgeInsets.symmetric(horizontal: 8.0);
final borderRadius = BorderRadius.circular(8.0);
