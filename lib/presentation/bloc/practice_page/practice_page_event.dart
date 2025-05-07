import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/data/models/unit.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/numerical_expression.dart";

sealed class PracticePageEvent {
  const PracticePageEvent();
}

final class PracticePageLessonLoaded extends PracticePageEvent {
  final Lesson lesson;
  final List<(Unit, Unit, num, List<((Unit, Unit), NumericalExpression)>, {bool isRetry})>
  questions;

  const PracticePageLessonLoaded({required this.lesson, required this.questions});
}

final class PracticePageLessonLoadFailure extends PracticePageEvent {
  final Object? error;

  const PracticePageLessonLoadFailure(this.error);
}

final class PracticePageInputChanged extends PracticePageEvent {
  final num input;

  const PracticePageInputChanged(this.input);
}

final class PracticePageAnswerSubmitted extends PracticePageEvent {
  const PracticePageAnswerSubmitted();
}

final class PracticePageNextQuestionClicked extends PracticePageEvent {
  const PracticePageNextQuestionClicked();
}

final class PracticePageToTransitionComplete extends PracticePageEvent {
  const PracticePageToTransitionComplete();
}

final class PracticePageFromTransitionComplete extends PracticePageEvent {
  const PracticePageFromTransitionComplete();
}

final class PracticePageReturnToLessonClicked extends PracticePageEvent {
  const PracticePageReturnToLessonClicked();
}
