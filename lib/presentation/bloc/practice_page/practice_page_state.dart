import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/data/models/unit.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/numerical_expression.dart";

part "practice_page_state.freezed.dart";

enum PracticePageStatus {
  /// Page loading related status
  loading,
  waitingForSubmission,

  /// Answer related status.
  evaluating,
  correct,
  incorrect,

  /// Transition related status.
  movingAway,
  movingIn,

  /// Problem set related status.
  finished,
  leaving,

  /// Runtime error related status.
  error,
}

@freezed
sealed class PracticePageState with _$PracticePageState {
  const PracticePageState._();
  const factory PracticePageState.loading({
    required PracticePageStatus status,
    required Lesson? lesson,
    required int chapterIndex,
    Object? error,
  }) = InitialPracticePageState;

  const factory PracticePageState.loaded({
    required PracticePageStatus status,
    required int chapterIndex,
    required Lesson lesson,
    required List<(Unit, Unit, num, List<((Unit, Unit), NumericalExpression)>, {bool isRetry})>
    questions,
    required int questionIndex,
    required double progress,
    required int mistakes,
    required DateTime startDateTime,
    double? answer,
    String? correctAnswer,
    Object? error,
  }) = LoadedPracticePageState;
}
