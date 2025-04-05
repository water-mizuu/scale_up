import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/expression.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/unit.dart";

part "chapter_page_state.freezed.dart";

enum ChapterPageStatus {
  /// Page loading related status
  loading,
  loaded,

  /// Answer related status.
  evaluating,
  correct,
  incorrect,
  movingToNextQuestion,
  completed,
  error,
}

@freezed
sealed class ChapterPageState with _$ChapterPageState {
  const factory ChapterPageState.initial({
    required ChapterPageStatus status,
    required Lesson lesson,
    required int chapterIndex,
    String? answer,
    String? correctAnswer,
    String? error,
  }) = InitialChapterPageState;

  const factory ChapterPageState.loaded({
    required ChapterPageStatus status,
    required int chapterIndex,
    required Lesson lesson,
    required List<(Unit, Unit, num, List<Expression>)> questions,
    required int questionIndex,
    String? answer,
    String? correctAnswer,
    String? error,
  }) = LoadedChapterPageState;
}
