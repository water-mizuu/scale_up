import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/expression.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/unit.dart";

part "practice_page_state.freezed.dart";

enum ChapterPageStatus {
  /// Page loading related status
  loading,
  loaded,

  /// Answer related status.
  evaluating,
  correct,
  incorrect,

  /// Transition related status.
  movingToNextQuestion,
  movedToNextQuestion,

  /// Problem set related status.
  finishedWithAllQuestions,

  /// Runtime error related status.
  error,
}

@freezed
sealed class PracticePageState with _$PracticePageState {
  const PracticePageState._();
  const factory PracticePageState.initial({
    required ChapterPageStatus status,
    required Lesson lesson,
    required int chapterIndex,
    String? answer,
    String? correctAnswer,
    String? error,
  }) = InitialPracticePageState;

  const factory PracticePageState.loaded({
    required ChapterPageStatus status,
    required int chapterIndex,
    required Lesson lesson,
    required List<(Unit, Unit, num, List<((Unit, Unit), Expression)>)> questions,
    required int questionIndex,
    String? answer,
    String? correctAnswer,
    String? error,
  }) = LoadedPracticePageState;

  double? get progress => switch (this) {
    InitialPracticePageState() => null,
    LoadedPracticePageState(:var questions, :var questionIndex) =>
      (questionIndex + 1) / (questions.length + 1),
  };
}
