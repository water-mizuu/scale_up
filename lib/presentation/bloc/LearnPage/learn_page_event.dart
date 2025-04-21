import "package:scale_up/data/sources/lessons/lessons_helper/expression.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";

sealed class LearnPageEvent {
  const LearnPageEvent();
}

final class LearnPageWidgetChangedEvent extends LearnPageEvent {
  const LearnPageWidgetChangedEvent({required this.lesson, required this.chapterIndex});

  final Lesson? lesson;
  final int chapterIndex;
}

final class LearnPageAnswerUpdatedEvent extends LearnPageEvent {
  const LearnPageAnswerUpdatedEvent({required this.answer});
  const LearnPageAnswerUpdatedEvent.directFormula({required Expression this.answer});

  final Object? answer;
}

final class LearnPageAnswerSubmittedEvent extends LearnPageEvent {
  const LearnPageAnswerSubmittedEvent();
}

final class LearnPageNextQuestionClickedEvent extends LearnPageEvent {
  const LearnPageNextQuestionClickedEvent();
}

final class LearnPageFromTransitionCompleteEvent extends LearnPageEvent {
  const LearnPageFromTransitionCompleteEvent();
}

final class LearnPageToTransitionCompleteEvent extends LearnPageEvent {
  const LearnPageToTransitionCompleteEvent();
}
