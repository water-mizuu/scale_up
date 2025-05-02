import "dart:async";

import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/models/conversion.dart";
import "package:scale_up/data/models/learn_chapter.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/data/models/unit.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/numerical_expression.dart";
import "package:scale_up/presentation/bloc/LearnPage/learn_page_event.dart";
import "package:scale_up/presentation/bloc/LearnPage/learn_page_state.dart";
import "package:scale_up/utils/extensions/choose_random_extension.dart";

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
    on<LearnPageReturnToLessonClicked>(_onReturnToLessonClicked);

    on<LearnPageMovingAwayComplete>(_onMovingAwayComplete);
    on<LearnPageMovingInComplete>(_onMovingInComplete);

    add(LearnPageWidgetChanged(lesson: lesson, chapterIndex: chapterIndex));
  }

  final LessonsHelper _lessonsHelper;

  @pragma("vm:prefer-inline")
  LoadedLearnPageState get loadedState => state as LoadedLearnPageState;

  @override
  void onEvent(LearnPageEvent event) {
    super.onEvent(event);

    if (kDebugMode) {
      print("[LEARN_PAGE_BLOC] $event");
    }
  }

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
      ///    the descriptive (plain) questions.
      for (var conversion in unitGroup.conversions) {
        var Conversion(:from, :to, formula: expression) = conversion;
        var unitGroupId = lesson.unitsType;
        var (fromUnit, toUnit) = (
          _lessonsHelper.getUnit(unitGroupId, from)!,
          _lessonsHelper.getUnit(unitGroupId, to)!,
        );

        var templates = _lessonsHelper.getTemplate("direct");
        if (templates == null) {
          throw Exception("Template not found for 'direct'.");
        }

        var generated = templates.generateRandom({
          "from": fromUnit.display ?? fromUnit.name,
          "to": toUnit.display ?? toUnit.name,
          "left_conversion_english": "",
          "number": expression.constants.map((c) => c.value).join(", "),
          "equation": expression.toString(),
        });

        questions.add(LearnQuestion.plain(informations: generated));
      }

      /// This block is responsible for generating
      ///    "What are the important numbers for converting from X to Y?"
      for (var conversion in unitGroup.conversions) {
        var Conversion(:from, :to, formula: expression) = conversion;
        var unitGroupId = lesson.unitsType;
        var (fromUnit, toUnit) = (
          _lessonsHelper.getUnit(unitGroupId, from)!,
          _lessonsHelper.getUnit(unitGroupId, to)!,
        );
        var constants = expression.constants.toSet();
        var correctAnswer = constants.map((c) => c.value).toSet();
        var choices = {correctAnswer};

        for (var i = 0; i < 3; ++i) {
          Set<num> mutatedAnswer;

          do {
            mutatedAnswer =
                constants
                    .take(correctAnswer.length)
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
        var unitGroupId = lesson.unitsType;
        var (fromUnit, toUnit) = (
          _lessonsHelper.getUnit(unitGroupId, from)!,
          _lessonsHelper.getUnit(unitGroupId, to)!,
        );
        var choices = [answer];

        for (var i = 0; i < 3; ++i) {
          NumericalExpression mutated;

          /// There is a probability that the mutated expression is unchanged.
          ///   So, we just keep mutating until we get a different one.
          do {
            mutated = answer.mutate();
          } while (choices.any((c) => c.str == mutated.str));

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
    } else if (learnChapter.type == "indirect") {
      var questions = <LearnQuestion>[];
      var unitGroupId = lesson.unitsType;
      var allUnits =
          learnChapter.units
              .map((u) => _lessonsHelper.getUnit(unitGroupId, u))
              .whereType<Unit>()
              .toList();
      var unitGroup = _lessonsHelper.getUnitGroupForUnits(allUnits);

      if (unitGroup == null) {
        throw Exception("There wasn't a unit group for $allUnits");
      }

      for (var from in learnChapter.units) {
        for (var to in learnChapter.units) {
          if (from == to) continue;

          var fromUnit = _lessonsHelper.getUnit(unitGroupId, from);
          var toUnit = _lessonsHelper.getUnit(unitGroupId, to);

          if (fromUnit == null || toUnit == null) {
            throw Exception("Unit not found");
          }

          var steps = _lessonsHelper.getConversionPathFor(fromUnit, toUnit);
          if (steps == null) {
            throw Exception("Path not found");
          }

          if (steps.length > 1) {
            var answer = [
              for (var ((from, to), _) in steps) ...[from, to],
            ];
            answer = answer.sublist(1, answer.length - 1);

            var choices = [
              ...answer,
              for (var i = 0; i < answer.length; ++i) unitGroup.units.chooseRandom(),
            ];

            choices.shuffle();

            questions.add(
              LearnQuestion.indirectSteps(
                from: fromUnit,
                to: toUnit,
                steps: steps,
                choices: choices,
                answer: answer,
              ),
            );
          }
        }
      }

      return questions;
    }

    return [];
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
          startDateTime: DateTime.now(),
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
    switch (question) {
      case PlainLearnQuestion():
        emit(loadedState.copyWith(status: LearnPageStatus.correct));
        return;
      case DirectFormulaLearnQuestion(answer: Object correctAnswer):
      case ImportantNumbersLearnQuestion(answer: Object correctAnswer):
      case IndirectStepsLearnQuestion(answer: Object correctAnswer):
        var answer = loadedState.answer;

        if (question.comparison(answer, correctAnswer)) {
          emit(
            loadedState.copyWith(status: LearnPageStatus.correct, correctAnswer: correctAnswer),
          );

          return;
        }

        var questions = loadedState.questions;
        var removed = questions[loadedState.questionIndex];
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
    late var mistakes = loadedState.mistakes;

    if (newQuestionIndex >= loadedState.questions.length) {
      emit(loadedState.copyWith(status: LearnPageStatus.finished, progress: 1.0));
      return;
    }

    emit(
      loadedState.copyWith(
        status: LearnPageStatus.movingIn,
        questionIndex: newQuestionIndex,
        progress: (newQuestionIndex - mistakes) / (loadedState.questions.length - mistakes),
        answer: null,
      ),
    );
  }

  void _onMovingInComplete(LearnPageMovingInComplete event, Emitter<LearnPageState> emit) async {
    emit(loadedState.copyWith(status: LearnPageStatus.waitingForSubmission));
  }

  void _onReturnToLessonClicked(
    LearnPageReturnToLessonClicked event,
    Emitter<LearnPageState> emit,
  ) async {
    emit(loadedState.copyWith(status: LearnPageStatus.leaving));
  }
}
