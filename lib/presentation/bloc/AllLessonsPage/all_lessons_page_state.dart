import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";

class AllLessonsPageState {
  AllLessonsPageState({
    required this.categoriesByTitle,
    required this.lessons,
    required this.keywords,
  });

  final List<(String, List<Lesson>)> categoriesByTitle;
  final List<Lesson> lessons;
  final Set<String> keywords;

  /// This is necessary as to avoid the equality check in emit.
  AllLessonsPageState update() {
    return AllLessonsPageState(
      categoriesByTitle: categoriesByTitle,
      lessons: lessons,
      keywords: keywords,
    );
  }
}
