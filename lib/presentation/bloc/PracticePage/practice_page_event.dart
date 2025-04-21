import "package:scale_up/data/sources/lessons/lessons_helper/expression.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/unit.dart";

sealed class PracticePageEvent {
  const PracticePageEvent();
}

final class PracticePageLessonLoaded extends PracticePageEvent {
  final Lesson lesson;
  final List<(Unit, Unit, num, List<((Unit, Unit), Expression)>)> questions;

  const PracticePageLessonLoaded({required this.lesson, required this.questions});
}

final class PracticePageLessonLoadFailure extends PracticePageEvent {
  final Object? error;

  const PracticePageLessonLoadFailure(this.error);
}

final class PracticePageInputChanged extends PracticePageEvent {
  final Expression input;

  const PracticePageInputChanged(this.input);
}

final class PracticePageAnswerSubmitted extends PracticePageEvent {
  const PracticePageAnswerSubmitted();
}

final class PracticePageNextQuestionClicked extends PracticePageEvent {
  const PracticePageNextQuestionClicked();
}

final class PracticePageToTransitionCompleteEvent extends PracticePageEvent {
  const PracticePageToTransitionCompleteEvent();
}

final class PracticePageFromTransitionCompleteEvent extends PracticePageEvent {
  const PracticePageFromTransitionCompleteEvent();
}
