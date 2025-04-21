import "package:scale_up/data/sources/lessons/lessons_helper/expression.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";

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
  const LearnPageAnswerUpdated.directFormula({required Expression this.answer});
  const LearnPageAnswerUpdated.importantNumbers({required Set<num> this.answer});

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
