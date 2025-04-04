import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/repositories/lessons/lesson.lessons_repository.dart";

part "lesson_page_state.freezed.dart";

@freezed
abstract class LessonPageState with _$LessonPageState {
  const LessonPageState._();

  const factory LessonPageState({
    required Lesson lesson,
  }) = _LessonPageState;
}
