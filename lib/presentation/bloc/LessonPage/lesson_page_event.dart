sealed class LessonPageEvent {}

class ChapterSelectedEvent extends LessonPageEvent {
  final int chapterIndex;

  ChapterSelectedEvent(this.chapterIndex);
}
