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
    required Future<Lesson?> lessonFuture,
    required int chapterIndex,
  }) : _lessonsHelper = lessonsHelper,
       super(
         LearnPageState.loading(
           status: LearnPageStatus.loading,
           chapterIndex: chapterIndex,
           lesson: lessonFuture,
         ),
       ) {
    on<LearnPageWidgetChangedEvent>(_onLearnPageWidgetChanged);
    on<FutureLoadedEvent>(_onFutureLoaded);

    on<LearnPageAnswerUpdatedEvent>(_onAnswerUpdated);
    on<LearnPageAnswerSubmittedEvent>(_onAnswerSubmitted);
    on<LearnPageNextQuestionClickedEvent>(_onNextQuestionClicked);

    on<LearnPageFromTransitionCompleteEvent>(_onFromTransitionComplete);
    on<LearnPageToTransitionCompleteEvent>(_onToTransitionComplete);

    _handleLessonFuture();
  }

  final LessonsHelper _lessonsHelper;

  @pragma("vm:prefer-inline")
  LoadedLearnPageState get loadedState => state as LoadedLearnPageState;

  /// This function handles the lesson future and emits the loaded state.
  ///   It does nothing if the state is already loaded or error.
  /// The future should be in the state object as well.
  Future<void> _handleLessonFuture() async {
    var state = this.state;
    if (this.state case ErrorLearnPageState() || LoadedLearnPageState()) return;
    assert(state is LoadingLearnPageState);

    var lesson = await (state as LoadingLearnPageState).lesson;
    var chapterIndex = state.chapterIndex;

    if (!isClosed) {
      add(FutureLoadedEvent(resolvedLessonFuture: lesson, chapterIndex: chapterIndex));
    }
  }

  void _onLearnPageWidgetChanged(
    LearnPageWidgetChangedEvent event,
    Emitter<LearnPageState> emit,
  ) async {
    emit(
      LearnPageState.loading(
        status: LearnPageStatus.loading,
        chapterIndex: event.chapterIndex,
        lesson: event.lessonFuture,
      ),
    );

    _handleLessonFuture();
  }

  void _onFutureLoaded(FutureLoadedEvent event, Emitter<LearnPageState> emit) async {
    var lesson = event.resolvedLessonFuture;
    if (lesson == null) {
      emit(LearnPageState.error(status: LearnPageStatus.error, error: "Lesson not found"));
      return;
    }

    try {
      emit(
        LearnPageState.loaded(
          status: LearnPageStatus.movingIn,
          lesson: event.resolvedLessonFuture!,
          chapterIndex: event.chapterIndex,
          questions: await _generateQuestions(lesson, lesson.learnChapters[event.chapterIndex]),
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
    await Future.delayed(Duration.zero);
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

  /// This generates questions for the given learn chapter.
  Future<List<LearnQuestion>> _generateQuestions(Lesson lesson, LearnChapter learnChapter) async {
    if (learnChapter.type == "direct") {
      var questions = <LearnQuestion>[];

      var unitGroup = await _lessonsHelper.getLocalExtendedUnitGroup(
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
        var (fromUnit, toUnit) =
            await (_lessonsHelper.getUnit(from), _lessonsHelper.getUnit(to)).wait;

        assert(fromUnit != null && toUnit != null);

        var path = await _lessonsHelper.getConversionPathFor(fromUnit!, toUnit!);
        assert(path != null && path.length == 1);

        var answer = path!.single.$2;
        var choices = [answer];
        for (var i = 0; i < 3; ++i) {
          Expression mutated;
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

      return questions;
    } else {
      return [];
    }
  }
}
