import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository/expression.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository/lesson.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository/unit.dart";

part "chapter_page_state.freezed.dart";

enum ChapterPageStatus { loading, loaded, nextQuestion, correct, incorrect, completed, error }

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

  const factory ChapterPageState.failure({
    required ChapterPageStatus status,
    required Lesson lesson,
    required int chapterIndex,
    String? answer,
    String? correctAnswer,
    String? error,
  }) = FailureChapterPageState;
}
