import "package:flutter/widgets.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/unit.dart";
import "package:scale_up/presentation/bloc/IndirectSteps/indirect_steps_state.dart";
import "package:scale_up/presentation/bloc/LearnPage/learn_page_bloc.dart";

class IndirectStepsCubit extends Cubit<IndirectStepsState> {
  IndirectStepsCubit(TickerProvider vsync, IndirectStepsLearnQuestion question)
    : super(
        IndirectStepsState(
          question: question,
          status: IndirectStepsStatus.idle,
          answers: List.filled(question.answer.length, null),
          choices: List<Unit?>.of(question.choices, growable: false),
          animationController: AnimationController(vsync: vsync, duration: 200.milliseconds),
          parentKey: GlobalKey(),
          answerKeys: List.generate(question.answer.length, (_) => GlobalKey()),
          choiceKeys: List.generate(question.choices.length, (_) => GlobalKey()),
          animation: null,
        ),
      );

  void answer(int choiceIndex) async {
    var unit = state.choices[choiceIndex];

    /// If the unit is not null, we can add it to the answers.
    if (unit case var unit?) {
      var availableIndex = 0;
      while (availableIndex < state.answers.length && state.answers[availableIndex] != null) {
        availableIndex++;
      }

      if (availableIndex >= state.answers.length) {
        return;
      }

      var updatedChoices = state.choices.toList();
      updatedChoices[choiceIndex] = null;

      emit(state.copyWith(choices: updatedChoices));
      await _animateMoveToAnswer(choiceIndex, availableIndex, unit);
      emit(state.copyWith(status: IndirectStepsStatus.idle, animation: null));

      var updatedAnswers = state.answers.toList();
      updatedAnswers[availableIndex] = (choiceIndex, unit);

      emit(state.copyWith(answers: updatedAnswers, choices: updatedChoices));
    }
  }

  void putBack(int answerIndex) async {
    if (state.answers[answerIndex] == null) {
      return;
    }

    var (choiceIndex, unit) = state.answers[answerIndex]!;

    var updatedAnswers = state.answers.toList();
    updatedAnswers[answerIndex] = null;

    emit(state.copyWith(answers: updatedAnswers));
    await _animateMoveBackToChoice(choiceIndex, answerIndex, unit);
    emit(state.copyWith(status: IndirectStepsStatus.idle, animation: null));

    var updatedChoices = state.choices.toList();
    updatedChoices[choiceIndex] = unit;

    emit(state.copyWith(answers: updatedAnswers, choices: updatedChoices));
  }

  Future<void> _animateMoveToAnswer(int choiceIndex, int availableIndex, Unit unit) async {
    var parentKey = state.parentKey;
    var choiceKey = state.choiceKeys[choiceIndex];
    var answerKey = state.answerKeys[availableIndex];

    if (parentKey.currentContext?.findRenderObject() case RenderBox parent) {
      if (choiceKey.currentContext?.findRenderObject() case RenderBox choice) {
        if (answerKey.currentContext?.findRenderObject() case RenderBox answer) {
          var choiceOffset = choice.localToGlobal(Offset.zero, ancestor: parent);
          var answerOffset = answer.localToGlobal(Offset.zero, ancestor: parent);

          state.animationController.reset();
          emit(
            state.copyWith(
              status: IndirectStepsStatus.animating,
              animation: (unit, choiceOffset, answerOffset),
            ),
          );

          await state.animationController.forward(from: 0.0);
        }
      }
    }
  }

  Future<void> _animateMoveBackToChoice(int choiceIndex, int answerIndex, Unit unit) async {
    var parentKey = state.parentKey;
    var choiceKey = state.choiceKeys[choiceIndex];
    var answerKey = state.answerKeys[answerIndex];

    if (parentKey.currentContext?.findRenderObject() case RenderBox parent) {
      if (choiceKey.currentContext?.findRenderObject() case RenderBox choice) {
        if (answerKey.currentContext?.findRenderObject() case RenderBox answer) {
          var choiceOffset = choice.localToGlobal(Offset.zero, ancestor: parent);
          var answerOffset = answer.localToGlobal(Offset.zero, ancestor: parent);

          state.animationController.reset();
          emit(
            state.copyWith(
              status: IndirectStepsStatus.animating,
              animation: (unit, answerOffset, choiceOffset),
            ),
          );
          await state.animationController.forward(from: 0.0);
        }
      }
    }
  }
}
