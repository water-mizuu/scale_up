import "dart:async";
import "dart:math";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/data/models/unit.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/numerical_expression.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_event.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_state.dart";

class PracticePageBloc extends Bloc<PracticePageEvent, PracticePageState> {
  PracticePageBloc({
    required LessonsHelper lessonsHelper,
    required Lesson? lesson,
    required int chapterIndex,
  }) : _lessonsHelper = lessonsHelper,
       super(
         PracticePageState.loading(
           status: PracticePageStatus.loading,
           lesson: lesson,
           chapterIndex: chapterIndex,
         ),
       ) {
    on<PracticePageLessonLoaded>(_onLessonLoaded);
    on<PracticePageLessonLoadFailure>(_onLessonLoadFailure);

    on<PracticePageInputChanged>(_onInputChanged);
    on<PracticePageAnswerSubmitted>(_onAnswerSubmitted);
    on<PracticePageNextQuestionClicked>(_onNextQuestionClicked);
    on<PracticePageReturnToLessonClicked>(_onReturnToLessonClicked);

    on<PracticePageToTransitionComplete>(_onToTransitionComplete);
    on<PracticePageFromTransitionComplete>(_onFromTransitionComplete);

    _initializeLesson();
  }

  final LessonsHelper _lessonsHelper;

  @pragma("vm:prefer-inline")
  LoadedPracticePageState get loadedState => state as LoadedPracticePageState;

  /// Initializes the lesson by loading it from the repository
  ///   and generating random unit pairs.
  Future<void> _initializeLesson() async {
    var lesson = state.lesson;
    if (lesson == null) {
      add(PracticePageLessonLoadFailure("Lesson not found"));
      return;
    }

    var chapter = lesson.practiceChapters[state.chapterIndex];

    /// We need te get units by random.
    var unitGroupId = lesson.unitsType;
    var allUnits = chapter.units.map((u) => _lessonsHelper.getUnit(unitGroupId, u)).toList();
    var unitMap = <String, Unit>{
      for (var unit in allUnits)
        if (unit != null) unit.id: unit,
    };

    var unitPairs = <(Unit, Unit, num, List<((Unit, Unit), NumericalExpression)>)>[];
    for (var i = 0; i < chapter.questionCount; ++i) {
      Unit fromUnit, toUnit;
      int randomNumber;
      List<((Unit, Unit), NumericalExpression)> conversions;

      do {
        var from = chapter.units.selectRandom();
        var to = chapter.units.where((v) => v != from).selectRandom();

        (fromUnit, toUnit) = (unitMap[from]!, unitMap[to]!);
        conversions = _lessonsHelper.getConversionPathFor(fromUnit, toUnit)!;
      } while (conversions.length > 3);

      randomNumber = Random().nextInt(100) + 20;
      unitPairs.add((fromUnit, toUnit, randomNumber, conversions));
    }

    add(PracticePageLessonLoaded(lesson: lesson, questions: unitPairs));
  }

  Future<void> _onLessonLoaded(
    PracticePageLessonLoaded event,
    Emitter<PracticePageState> emit,
  ) async {
    var PracticePageLessonLoaded(:lesson, :questions) = event;

    emit(
      PracticePageState.loaded(
        status:
            (questions.isEmpty) //
                ? PracticePageStatus.finished
                : PracticePageStatus.movingIn,
        lesson: lesson,
        chapterIndex: state.chapterIndex,
        questions: questions,
        questionIndex: 0,
        answer: 0,
        progress: 0.0,
        mistakes: 0,
        startDateTime: DateTime.now(),
      ),
    );
  }

  Future<void> _onLessonLoadFailure(
    PracticePageLessonLoadFailure event,
    Emitter<PracticePageState> emit,
  ) async {
    emit(state.copyWith(status: PracticePageStatus.error, error: event.error));
  }

  Future<void> _onInputChanged(
    PracticePageInputChanged event,
    Emitter<PracticePageState> emit,
  ) async {
    try {
      var expression = event.input;
      var parsedInput = expression.evaluate({}).toDouble();

      emit(loadedState.copyWith(answer: parsedInput));
    } on UnsupportedError {
      return;
    }
  }

  Future<void> _onAnswerSubmitted(
    PracticePageAnswerSubmitted event,
    Emitter<PracticePageState> emit,
  ) async {
    emit(loadedState.copyWith(status: PracticePageStatus.evaluating));
    await Future.delayed(Duration.zero);

    var (_, _, fromNum, exprs) = loadedState.questions[loadedState.questionIndex];
    var correctAnswer = exprs.map((p) => p.$2).toList().evaluate(fromNum).toStringAsPrecision(4);
    var userAnswer = loadedState.answer?.toStringAsPrecision(4);

    if (userAnswer == correctAnswer) {
      emit(
        loadedState.copyWith(status: PracticePageStatus.correct, correctAnswer: correctAnswer),
      );

      return;
    }

    var questions = loadedState.questions;
    var removed = questions[loadedState.questionIndex];
    var newQuestions = questions.followedBy([removed]).toList();

    emit(
      loadedState.copyWith(
        status: PracticePageStatus.incorrect,
        correctAnswer: correctAnswer,
        questions: newQuestions,
        mistakes: loadedState.mistakes + 1,
      ),
    );
  }

  Future<void> _onNextQuestionClicked(
    PracticePageNextQuestionClicked event,
    Emitter<PracticePageState> emit,
  ) async {
    emit(state.copyWith(status: PracticePageStatus.movingAway));
  }

  void _onToTransitionComplete(
    PracticePageToTransitionComplete event,
    Emitter<PracticePageState> emit,
  ) async {
    /// Since there is a calculator, the default answer is 0.
    emit(loadedState.copyWith(status: PracticePageStatus.waitingForSubmission, answer: 0));
  }

  void _onFromTransitionComplete(
    PracticePageFromTransitionComplete event,
    Emitter<PracticePageState> emit,
  ) async {
    var newQuestionIndex = loadedState.questionIndex + 1;
    late var mistakes = loadedState.mistakes;

    if (newQuestionIndex >= loadedState.questions.length) {
      emit(loadedState.copyWith(status: PracticePageStatus.finished, progress: 1.0));
    } else {
      emit(
        loadedState.copyWith(
          status: PracticePageStatus.movingIn,
          questionIndex: newQuestionIndex,
          progress: (newQuestionIndex - mistakes) / (loadedState.questions.length - mistakes),
        ),
      );
    }
  }

  void _onReturnToLessonClicked(
    PracticePageReturnToLessonClicked event,
    Emitter<PracticePageState> emit,
  ) async {
    emit(loadedState.copyWith(status: PracticePageStatus.leaving));
  }
}

extension<T> on Iterable<T> {
  T selectRandom() {
    if (isEmpty) {
      throw Exception("Cannot select random element from empty set");
    }

    T? selected;
    double maxRandom = -1.0;

    for (var item in this) {
      double random = Random().nextDouble();
      if (random > maxRandom) {
        selected = item;
        maxRandom = random;
      }
    }

    return selected!;
  }
}
