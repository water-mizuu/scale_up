import "package:dotted_border/dotted_border.dart";
import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:provider/provider.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/expression.dart";
import "package:scale_up/presentation/bloc/LearnPage/learn_page_bloc.dart";
import "package:scale_up/utils/animation_controller_distinction.dart";

class Choices extends StatelessWidget {
  const Choices({super.key});

  @override
  Widget build(BuildContext context) {
    // var learnPageBloc = context.read<LearnPageBloc>();
    // var LoadedLearnPageState(:questions, :questionIndex) = learnPageBloc.loadedState;
    // var currentQuestion = questions[questionIndex];
    var currentQuestion = context.select(
      (LearnPageBloc bloc) => bloc.loadedState.questions[bloc.loadedState.questionIndex],
    );

    switch (currentQuestion) {
      case DirectFormulaLearnQuestion():
        return DirectFormulaChoices(currentQuestion: currentQuestion);
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
class DirectFormulaChoices extends StatelessWidget {
  const DirectFormulaChoices({super.key, required this.currentQuestion});

  final DirectFormulaLearnQuestion currentQuestion;

  @override
  Widget build(BuildContext context) {
    var DirectFormulaLearnQuestion(:choices) = currentQuestion;

    return Column(
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
    );
  }
}

class DirectFormulaChoice extends StatelessWidget {
  const DirectFormulaChoice({super.key, required this.choice, required this.currentQuestion});

  final Expression choice;
  final DirectFormulaLearnQuestion currentQuestion;

  @override
  Widget build(BuildContext context) {
    var DirectFormulaLearnQuestion(:from, :to) = currentQuestion;
    var learnPageBloc = context.watch<LearnPageBloc>();
    var hslColor = learnPageBloc.loadedState.lesson.hslColor;
    var answer = learnPageBloc.loadedState.answer;
    var backgroundColor =
        hslColor.withSaturation(hslColor.saturation * 0.5).withLightness(0.95).toColor();

    Widget widget = Material(
      elevation: 12.0,
      borderRadius: BorderRadius.circular(8.0),
      child: ListTile(
        onTap: () {
          learnPageBloc.add(LearnPageAnswerUpdatedEvent.directFormula(answer: choice));
        },
        tileColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        title: Text(
          "${to.shortcut} = ${choice.substitute("from", VariableExpression(from.shortcut))}",
        ),
      ),
    );

    if (learnPageBloc.loadedState.status
        case LearnPageStatus.correct || LearnPageStatus.incorrect) {
      var LoadedLearnPageState(:correctAnswer, :answer) = learnPageBloc.loadedState;

      if (choice == correctAnswer) {
        widget = DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(8.0),
          dashPattern: [4, 4],
          strokeWidth: 2.0,
          color: Colors.green,
          child: widget,
        );
      } else if (choice == answer && choice != correctAnswer) {
        widget = DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(8.0),
          dashPattern: [4, 4],
          strokeWidth: 2.0,
          color: Colors.red,
          child: widget,
        );
      }
    } else if (choice == answer) {
      widget = DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(8.0),
        dashPattern: [4, 4],
        strokeWidth: 2.0,
        color: Colors.green,
        child: widget,
      );
    }

    return widget;
  }
}
