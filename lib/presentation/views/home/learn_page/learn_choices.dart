import "package:dotted_border/dotted_border.dart";
import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/expression.dart";
import "package:scale_up/presentation/bloc/LearnPage/learn_page_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/box_shadow.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/animation_controller_distinction.dart";

class LearnChoices extends StatelessWidget {
  const LearnChoices({super.key});

  @override
  Widget build(BuildContext context) {
    // var learnPageBloc = context.read<LearnPageBloc>();
    // var LoadedLearnPageState(:questions, :questionIndex) = learnPageBloc.loadedState;
    // var currentQuestion = questions[questionIndex];

    var currentQuestion = context.select(
      (LearnPageBloc b) => b.loadedState.questions[b.loadedState.questionIndex],
    );

    switch (currentQuestion) {
      case DirectFormulaLearnQuestion():
        return DirectFormulaChoices(currentQuestion: currentQuestion);
      case ImportantNumbersLearnQuestion():
        return ImportantNumbersChoices(currentQuestion: currentQuestion);
      case IndirectStepsLearnQuestion():

        /// TODO: Implement this
        throw UnimplementedError();
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

  final Expression choice;
  final DirectFormulaLearnQuestion currentQuestion;

  @override
  Widget build(BuildContext context) {
    var DirectFormulaLearnQuestion(:from, :to, :comparison) = currentQuestion;
    var learnPageBloc = context.watch<LearnPageBloc>();
    var hslColor = learnPageBloc.loadedState.lesson.hslColor;
    var answer = learnPageBloc.loadedState.answer;
    var backgroundColor =
        hslColor.withSaturation(hslColor.saturation * 0.5).withLightness(0.95).toColor();

    Widget widget = DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: defaultBoxShadow,
      ),
      child: ListTile(
        onTap: () {
          learnPageBloc.add(LearnPageAnswerUpdated.directFormula(answer: choice));
        },
        tileColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        title: Text(
          "${to.shortcut} = ${choice.substituteString("from", from.shortcut)}",
          style: GoogleFonts.notoSansMath(),
        ),
      ),
    );

    if (learnPageBloc.loadedState.status
        case LearnPageStatus.correct || LearnPageStatus.incorrect) {
      var LoadedLearnPageState(:correctAnswer, :answer) = learnPageBloc.loadedState;

      if (comparison(choice, correctAnswer)) {
        widget = DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(8.0),
          dashPattern: [4, 4],
          strokeWidth: 2.0,
          color: Colors.green,
          child: widget,
        );
      } else if (comparison(choice, answer) && !comparison(choice, correctAnswer)) {
        widget = DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(8.0),
          dashPattern: [4, 4],
          strokeWidth: 2.0,
          color: Colors.red,
          child: widget,
        );
      }
    } else if (comparison(choice, answer)) {
      widget = DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(8.0),
        dashPattern: [4, 4],
        strokeWidth: 2.0,
        color: Colors.blue,
        child: widget,
      );
    }

    if (widget is! DottedBorder) {
      widget = DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(8.0),
        dashPattern: [4, 4],
        strokeWidth: 2.0,
        color: Colors.transparent,
        child: widget,
      );
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
            .withSaturation(hslColor.saturation * 0.5)
            .withLightness(0.92)
            .toColor();

    Widget widget = DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: defaultBoxShadow,
      ),
      child: ListTile(
        onTap: () {
          learnPageBloc.add(LearnPageAnswerUpdated.importantNumbers(answer: choice));
        },
        tileColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        title: Text(choice.join(", "), style: GoogleFonts.notoSansMath()),
      ),
    );

    if (learnPageBloc.loadedState.status
        case LearnPageStatus.correct || LearnPageStatus.incorrect) {
      var LoadedLearnPageState(:correctAnswer, :answer) = learnPageBloc.loadedState;

      if (comparison(choice, correctAnswer)) {
        widget = DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(8.0),
          dashPattern: [4, 4],
          strokeWidth: 2.0,
          color: Colors.green,
          child: widget,
        );
      } else if (comparison(choice, answer) && !comparison(choice, correctAnswer)) {
        widget = DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(8.0),
          dashPattern: [4, 4],
          strokeWidth: 2.0,
          color: Colors.red,
          child: widget,
        );
      }
    } else if (comparison(choice, answer)) {
      widget = DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(8.0),
        dashPattern: [4, 4],
        strokeWidth: 2.0,
        color: Colors.blue,
        child: widget,
      );
    }

    if (widget is! DottedBorder) {
      widget = DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(8.0),
        dashPattern: [4, 4],
        strokeWidth: 2.0,
        color: Colors.transparent,
        child: widget,
      );
    }

    return widget;
  }
}
