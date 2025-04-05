import "package:scale_up/data/sources/lessons/lessons_helper/expression.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/unit.dart";

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
  final Expression input;

  const ChapterPageInputChanged(this.input);
}

final class ChapterPageAnswerSubmitted extends ChapterPageEvent {
  const ChapterPageAnswerSubmitted();
}

final class ChapterPageNextQuestion extends ChapterPageEvent {
  const ChapterPageNextQuestion();
}