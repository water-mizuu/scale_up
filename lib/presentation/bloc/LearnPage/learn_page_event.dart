import "package:scale_up/data/sources/lessons/lessons_helper/numerical_expression.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/data/models/unit.dart";

sealed class LearnPageEvent {
  const LearnPageEvent();
}

final class LearnPageWidgetChanged extends LearnPageEvent {
  const LearnPageWidgetChanged({required this.lesson, required this.chapterIndex});

  final Lesson? lesson;
  final int chapterIndex;
}

final class LearnPageAnswerUpdated extends LearnPageEvent {
  const LearnPageAnswerUpdated({required this.answer});
  const LearnPageAnswerUpdated.directFormula({required NumericalExpression this.answer});
  const LearnPageAnswerUpdated.importantNumbers({required Set<num> this.answer});
  const LearnPageAnswerUpdated.indirectSteps({required List<Unit>? this.answer});

  final Object? answer;
}

final class LearnPageAnswerSubmitted extends LearnPageEvent {
  const LearnPageAnswerSubmitted();
}

final class LearnPageNextQuestionClicked extends LearnPageEvent {
  const LearnPageNextQuestionClicked();
}

final class LearnPageMovingAwayComplete extends LearnPageEvent {
  const LearnPageMovingAwayComplete();
}

final class LearnPageMovingInComplete extends LearnPageEvent {
  const LearnPageMovingInComplete();
}

final class LearnPageReturnToLessonClicked extends LearnPageEvent {
  const LearnPageReturnToLessonClicked();
}
