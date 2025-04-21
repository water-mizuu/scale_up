import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/conversion.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/expression.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/learn_chapter.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/presentation/bloc/LearnPage/learn_page_event.dart";
import "package:scale_up/presentation/bloc/LearnPage/learn_page_state.dart";

export "learn_page_event.dart";
export "learn_page_state.dart";

class LearnPageBloc extends Bloc<LearnPageEvent, LearnPageState> {
  LearnPageBloc({
    required LessonsHelper lessonsHelper,
    required Lesson? lesson,
    required int chapterIndex,
  }) : _lessonsHelper = lessonsHelper,
       super(
         LearnPageState.loading(
           status: LearnPageStatus.loading,
           lesson: lesson,
           chapterIndex: chapterIndex,
         ),
       ) {
    on<LearnPageWidgetChangedEvent>(_onLearnPageWidgetChanged);

    on<LearnPageAnswerUpdatedEvent>(_onAnswerUpdated);
    on<LearnPageAnswerSubmittedEvent>(_onAnswerSubmitted);
    on<LearnPageNextQuestionClickedEvent>(_onNextQuestionClicked);

    on<LearnPageFromTransitionCompleteEvent>(_onFromTransitionComplete);
    on<LearnPageToTransitionCompleteEvent>(_onToTransitionComplete);

    add(LearnPageWidgetChangedEvent(lesson: lesson, chapterIndex: chapterIndex));
  }

  final LessonsHelper _lessonsHelper;

  @pragma("vm:prefer-inline")
  LoadedLearnPageState get loadedState => state as LoadedLearnPageState;

  /// This generates questions for the given learn chapter.
  List<LearnQuestion> _generateQuestions(Lesson lesson, LearnChapter learnChapter) {
    if (learnChapter.type == "direct") {
      var questions = <LearnQuestion>[];

      var unitGroup = _lessonsHelper.getLocalExtendedUnitGroup(
        lesson.unitsType,
        learnChapter.units,
      );
      if (unitGroup == null) {
        throw Exception("Unit group not found");
      }

      var units = unitGroup.units;
      for (var conversion in unitGroup.conversions) {
        assert(units.isNotEmpty);
        assert(units.length == units.whereType<Object>().length);

        var Conversion(:from, :to) = conversion;
        var (fromUnit, toUnit) = (_lessonsHelper.getUnit(from)!, _lessonsHelper.getUnit(to)!);
        var path = _lessonsHelper.getConversionPathFor(fromUnit, toUnit);
        assert(path != null && path.length == 1);

        var (_, answer) = path!.single;
        var choices = [answer];

        /// This block is responsible for generating
        ///   "What is the formula for converting from X to Y?"
        ///   questions.
        {
          for (var i = 0; i < 3; ++i) {
            Expression mutated;

            /// There is a probability that the mutated expression is unchanged.
            ///   So, we just keep mutating until we get a different one.
            do {
              mutated = answer.mutate();
            } while (mutated.toString() == answer.toString());

            choices.add(mutated);
          }
          choices.shuffle();
          assert(choices.contains(answer));

          /// To make choices, we have to "mutate" the answer.
          questions.add(
            LearnQuestion.directFormula(
              from: fromUnit,
              to: toUnit,
              choices: choices,
              answer: answer,
            ),
          );
        }

        /// This block is responsible for generating
        ///    "What are the constants for converting from X to Y?"
        {
          var constants = answer.constants.toSet();
          var correctAnswer = constants.map((c) => c.value).toSet();
          var choices = {correctAnswer};

          for (var i = 0; i < 3; ++i) {
            Set<num> mutatedAnswer;

            do {
              mutatedAnswer =
                  constants
                      .map((c) => c.mutate())
                      .whereType<ConstantExpression>()
                      .map((c) => c.value)
                      .toSet();
            } while (choices.any((c) => c.difference(mutatedAnswer).isEmpty));

            choices.add(mutatedAnswer);
          }

          questions.add(
            LearnQuestion.importantNumbers(
              from: fromUnit,
              to: toUnit,
              choices: choices,
              answer: correctAnswer,
            ),
          );
        }
      }

      return questions;
    } else {
      return [];
    }
  }

  void _onLearnPageWidgetChanged(
    LearnPageWidgetChangedEvent event,
    Emitter<LearnPageState> emit,
  ) async {
    try {
      var lesson = event.lesson;

      if (lesson == null) {
        throw Exception("Lesson not found");
      }

      emit(
        LearnPageState.loaded(
          status: LearnPageStatus.movingIn,
          lesson: lesson,
          chapterIndex: event.chapterIndex,
          questions: _generateQuestions(lesson, lesson.learnChapters[event.chapterIndex]),
          questionIndex: 0,
          progress: 0.0,
        ),
      );
    } on Exception catch (e) {
      emit(LearnPageState.error(status: LearnPageStatus.error, error: e.toString()));
    }
  }

  void _onAnswerSubmitted(
    LearnPageAnswerSubmittedEvent event,
    Emitter<LearnPageState> emit,
  ) async {
    assert(state is LoadedLearnPageState, "State should be loaded.");
    emit(loadedState.copyWith(status: LearnPageStatus.evaluating));
    await Future.delayed(Duration.zero);

    var correctAnswer = loadedState.questions[loadedState.questionIndex].answer;
    var answer = loadedState.answer;

    if (correctAnswer == answer) {
      emit(loadedState.copyWith(status: LearnPageStatus.correct, correctAnswer: correctAnswer));
    } else {
      emit(loadedState.copyWith(status: LearnPageStatus.incorrect, correctAnswer: correctAnswer));
    }
  }

  void _onAnswerUpdated(LearnPageAnswerUpdatedEvent event, Emitter<LearnPageState> emit) async {
    assert(state is LoadedLearnPageState);

    emit(loadedState.copyWith(answer: event.answer));
  }

  void _onNextQuestionClicked(
    LearnPageNextQuestionClickedEvent event,
    Emitter<LearnPageState> emit,
  ) async {
    emit(loadedState.copyWith(status: LearnPageStatus.movingAway));
  }

  void _onFromTransitionComplete(
    LearnPageFromTransitionCompleteEvent event,
    Emitter<LearnPageState> emit,
  ) async {
    var newQuestionIndex = loadedState.questionIndex + 1;

    if (newQuestionIndex >= loadedState.questions.length) {
      emit(loadedState.copyWith(status: LearnPageStatus.finishedWithAllQuestions, progress: 1.0));
      return;
    }
    emit(
      loadedState.copyWith(
        status: LearnPageStatus.movingIn,
        questionIndex: newQuestionIndex,
        progress: newQuestionIndex / loadedState.questions.length,
      ),
    );
  }

  void _onToTransitionComplete(
    LearnPageToTransitionCompleteEvent event,
    Emitter<LearnPageState> emit,
  ) async {
    emit(loadedState.copyWith(status: LearnPageStatus.waitingForSubmission, answer: null));
  }
}
