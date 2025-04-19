import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/expression.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/unit.dart";

part "learn_page_state.freezed.dart";

enum LearnPageStatus {
  /// Page loading related status
  loading,
  loaded,
  waitingForSubmission,

  /// Answer related status.
  evaluating,
  correct,
  incorrect,

  /// Transition related status.
  movingAway,
  movingIn,

  /// Problem set related status.
  finishedWithAllQuestions,

  /// Runtime error related status.
  error,
}

@freezed
sealed class LearnPageState with _$LearnPageState {
  const LearnPageState._();

  const factory LearnPageState.loading({
    required LearnPageStatus status,
    required Future<Lesson?> lesson,
    required int chapterIndex,
  }) = LoadingLearnPageState;

  const factory LearnPageState.error({required LearnPageStatus status, required String error}) =
      ErrorLearnPageState;

  const factory LearnPageState.loaded({
    required LearnPageStatus status,
    required int chapterIndex,
    required Lesson lesson,
    required List<LearnQuestion> questions,
    required int questionIndex,
    required double progress,
    Object? answer,
    Object? correctAnswer,
    String? error,
  }) = LoadedLearnPageState;
}

@freezed
sealed class LearnQuestion with _$LearnQuestion {
  const LearnQuestion._();

  const factory LearnQuestion.directFormula({
    required Unit from,
    required Unit to,
    required List<Expression> choices,
    required Expression answer,
  }) = DirectFormulaLearnQuestion;

  const factory LearnQuestion.importantNumbers({
    required Unit from,
    required Unit to,
    required List<Expression> choices,
    required List<num> answer,
  }) = ImportantNumbersLearnQuestion;

  const factory LearnQuestion.indirectSteps({
    required Unit from,
    required Unit to,
    required List<((Unit, Unit), Expression)> steps,
    required List<Unit> choices,
    required List<Object> answer,
  }) = IndirectStepsLearnQuestion;
}
