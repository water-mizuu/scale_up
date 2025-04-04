import "package:scale_up/data/repositories/lessons/lessons_repository/expression.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository/lesson.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository/unit.dart";

sealed class ChapterPageEvent {
  const ChapterPageEvent();
}

final class ChapterPageLessonLoaded extends ChapterPageEvent {
  final Lesson lesson;
  final List<(Unit, Unit, num, List<Expression>)> questions;

  const ChapterPageLessonLoaded({
    required this.lesson,
    required this.questions,
  });
}

final class ChapterPageLessonLoadFailure extends ChapterPageEvent {
  final Object? error;

  const ChapterPageLessonLoadFailure(this.error);
}

final class ChapterPageInputChanged extends ChapterPageEvent {
  final String input;

  const ChapterPageInputChanged(this.input);
}

final class ChapterPageAnswerSubmitted extends ChapterPageEvent {
  const ChapterPageAnswerSubmitted();
}

final class ChapterPageNextQuestion extends ChapterPageEvent {
  const ChapterPageNextQuestion();
}