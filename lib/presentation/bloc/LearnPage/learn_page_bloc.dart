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
    on<LearnPageWidgetChanged>(_onLearnPageWidgetChanged);

    on<LearnPageAnswerUpdated>(_onAnswerUpdated);
    on<LearnPageAnswerSubmitted>(_onAnswerSubmitted);
    on<LearnPageNextQuestionClicked>(_onNextQuestionClicked);

    on<LearnPageMovingAwayComplete>(_onMovingAwayComplete);
    on<LearnPageMovingInComplete>(_onMovingInComplete);

    add(LearnPageWidgetChanged(lesson: lesson, chapterIndex: chapterIndex));
  }

  final LessonsHelper _lessonsHelper;

  @pragma("vm:prefer-inline")
  LoadedLearnPageState get loadedState => state as LoadedLearnPageState;

  /// This generates questions for the given learn chapter.
  List<LearnQuestion> _generateQuestions(Lesson lesson, LearnChapter learnChapter) {
    if (learnChapter.type == "direct") {
      var questions = <LearnQuestion>[];

      var unitGroup = _lessonsHelper.getLocalUnitGroup(lesson.unitsType, learnChapter.units);
      var extendedUnitGroup = _lessonsHelper.getLocalExtendedUnitGroup(
        lesson.unitsType,
        learnChapter.units,
      );
      if (unitGroup == null || extendedUnitGroup == null) {
        throw Exception("Unit group not found");
      }

      /// This block is responsible for generating
      ///    "What are the important numbers for converting from X to Y?"
      for (var conversion in unitGroup.conversions) {
        var Conversion(:from, :to, formula: expression) = conversion;
        var (fromUnit, toUnit) = (_lessonsHelper.getUnit(from)!, _lessonsHelper.getUnit(to)!);
        var constants = expression.constants.toSet();
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

      questions.shuffle();

      /// This block is responsible for generating
      ///   "What is the formula for converting from X to Y?"
      ///   questions.
      var units = extendedUnitGroup.units;
      for (var conversion in extendedUnitGroup.conversions) {
        assert(units.isNotEmpty);
        assert(units.length == units.whereType<Object>().length);

        var Conversion(:from, :to, formula: answer) = conversion;
        var (fromUnit, toUnit) = (_lessonsHelper.getUnit(from)!, _lessonsHelper.getUnit(to)!);
        var choices = [answer];

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
      questions.shuffle();

      return questions;
    } else {
      return [];
    }
  }

  void _onLearnPageWidgetChanged(
    LearnPageWidgetChanged event,
    Emitter<LearnPageState> emit,
  ) async {
    try {
      var lesson = event.lesson;

      if (lesson == null) {
        throw Exception("Lesson not found");
      }

      var questions = _generateQuestions(lesson, lesson.learnChapters[event.chapterIndex]);

      emit(
        LearnPageState.loaded(
          status: LearnPageStatus.movingIn,
          lesson: lesson,
          chapterIndex: event.chapterIndex,
          questions: questions,
          comparison: questions.first.comparison,
          questionIndex: 0,
          progress: 0.0,
          mistakes: 0,
        ),
      );
    } on Exception catch (e) {
      emit(LearnPageState.error(status: LearnPageStatus.error, error: e.toString()));
    }
  }

  void _onAnswerSubmitted(LearnPageAnswerSubmitted event, Emitter<LearnPageState> emit) async {
    assert(state is LoadedLearnPageState, "State should be loaded.");
    emit(loadedState.copyWith(status: LearnPageStatus.evaluating));
    await Future.delayed(Duration.zero);

    var question = loadedState.questions[loadedState.questionIndex];
    var correctAnswer = question.answer;
    var answer = loadedState.answer;

    if (question.comparison(answer, correctAnswer)) {
      emit(loadedState.copyWith(status: LearnPageStatus.correct, correctAnswer: correctAnswer));
    } else {
      var questions = loadedState.questions;
      var removed = questions.elementAt(loadedState.questionIndex);
      var newQuestions = questions.followedBy([removed]).toList();

      /// PROBLEM:
      ///   When the user answers incorrectly, since we update the [questions],
      ///   The [questionIndex] is not updated.
      emit(
        loadedState.copyWith(
          status: LearnPageStatus.incorrect,
          correctAnswer: correctAnswer,
          questions: newQuestions,
          mistakes: loadedState.mistakes + 1,
        ),
      );
    }
  }

  void _onAnswerUpdated(LearnPageAnswerUpdated event, Emitter<LearnPageState> emit) async {
    assert(state is LoadedLearnPageState);

    emit(loadedState.copyWith(answer: event.answer));
  }

  void _onNextQuestionClicked(
    LearnPageNextQuestionClicked event,
    Emitter<LearnPageState> emit,
  ) async {
    emit(loadedState.copyWith(status: LearnPageStatus.movingAway));
  }

  void _onMovingAwayComplete(
    LearnPageMovingAwayComplete event,
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
        progress:
            (newQuestionIndex - loadedState.mistakes) /
            (loadedState.questions.length - loadedState.mistakes),
        answer: null,
      ),
    );
  }

  void _onMovingInComplete(LearnPageMovingInComplete event, Emitter<LearnPageState> emit) async {
    emit(loadedState.copyWith(status: LearnPageStatus.waitingForSubmission));
  }
}
