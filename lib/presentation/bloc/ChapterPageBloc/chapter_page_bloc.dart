import "dart:async";
import "dart:math";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/expression.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/unit.dart";
import "package:scale_up/presentation/bloc/ChapterPageBloc/chapter_page_event.dart";
import "package:scale_up/presentation/bloc/ChapterPageBloc/chapter_page_state.dart";
import "package:scale_up/utils/to_string_as_fixed_max_extension.dart";

class ChapterPageBloc extends Bloc<ChapterPageEvent, ChapterPageState> {
  ChapterPageBloc({
    required LessonsHelper lessonsRepository,
    required Lesson lesson,
    required int chapterIndex,
  }) : _lessonsRepository = lessonsRepository,
       super(
         ChapterPageState.initial(
           lesson: lesson,
           chapterIndex: chapterIndex,
           status: ChapterPageStatus.loading,
         ),
       ) {
    on<ChapterPageLessonLoaded>(_onLessonLoaded);
    on<ChapterPageLessonLoadFailure>(_onLessonLoadFailure);
    on<ChapterPageInputChanged>(_onInputChanged);
    on<ChapterPageAnswerSubmitted>(_onAnswerSubmitted);
    on<ChapterPageNextQuestion>(_onNextQuestion);

    _initializeLesson(lesson);
  }

  final LessonsHelper _lessonsRepository;

  /// Initializes the lesson by loading it from the repository
  ///   and generating random unit pairs.
  Future<void> _initializeLesson(Lesson lesson) async {
    var chapter = lesson.chapters[state.chapterIndex];

    /// We need te get units by random.
    var allUnits = await Future.wait(chapter.units.map((id) => _lessonsRepository.getUnit(id)));
    var unitMap = <String, Unit>{
      for (var unit in allUnits)
        if (unit != null) unit.id: unit,
    };

    var unitPairs = <(Unit, Unit, num, List<Expression>)>[];
    for (var i = 0; i < chapter.questionCount; ++i) {
      var from = chapter.units.selectRandom();
      var to = chapter.units.where((v) => v != from).selectRandom();

      var (fromUnit, toUnit) = (unitMap[from]!, unitMap[to]!);
      var conversions = await _lessonsRepository //
          .getConversionPathFor(fromUnit, toUnit)
          .then((v) => v!);
      var randomNumber = Random().nextInt(100) + 20;

      unitPairs.add((fromUnit, toUnit, randomNumber, conversions));
    }

    add(ChapterPageLessonLoaded(lesson: lesson, questions: unitPairs));
  }

  Future<void> _onLessonLoaded(
    ChapterPageLessonLoaded event,
    Emitter<ChapterPageState> emit,
  ) async {
    var ChapterPageLessonLoaded(:lesson, :questions) = event;

    emit(
      ChapterPageState.loaded(
        status:
            (questions.isEmpty) //
                ? ChapterPageStatus.finished
                : ChapterPageStatus.loaded,
        lesson: lesson,
        chapterIndex: state.chapterIndex,
        questions: questions,
        questionIndex: 0,
        answer: 0.toStringAsFixed(3),
      ),
    );
  }

  Future<void> _onLessonLoadFailure(
    ChapterPageLessonLoadFailure event,
    Emitter<ChapterPageState> emit,
  ) async {
    emit(state.copyWith(status: ChapterPageStatus.error));
  }

  Future<void> _onInputChanged(
    ChapterPageInputChanged event,
    Emitter<ChapterPageState> emit,
  ) async {
    try {
      var expression = event.input;
      var parsedInput = expression.evaluate({});

      emit(state.copyWith(answer: parsedInput.toStringAsFixedMax(3)));
    } on UnsupportedError {
      return;
    }
  }

  Future<void> _onAnswerSubmitted(
    ChapterPageAnswerSubmitted event,
    Emitter<ChapterPageState> emit,
  ) async {
    emit(state.copyWith(status: ChapterPageStatus.evaluating));

    assert(state is LoadedChapterPageState);
    if (state case LoadedChapterPageState state) {
      var (_, _, fromNum, expr) = state.questions[state.questionIndex];
      var answer = expr.evaluate(fromNum).toStringAsFixedMax(3);

      if (state.answer == answer) {
        emit(state.copyWith(status: ChapterPageStatus.correct));
      } else {
        emit(state.copyWith(status: ChapterPageStatus.incorrect, correctAnswer: answer));
      }
    }
  }

  Future<void> _onNextQuestion(
    ChapterPageNextQuestion event,
    Emitter<ChapterPageState> emit,
  ) async {
    assert(state is LoadedChapterPageState);
    emit(state.copyWith(status: ChapterPageStatus.movingToNextQuestion));

    if (state case LoadedChapterPageState state) {
      var questionIndex = state.questionIndex + 1;

      if (questionIndex >= state.questions.length) {
        emit(state.copyWith(status: ChapterPageStatus.finished));
      } else {
        emit(
          state.copyWith(
            status: ChapterPageStatus.loaded,
            questionIndex: questionIndex,
            answer: 0.toStringAsFixed(3),
          ),
        );
      }
    }
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
