import "package:scale_up/data/repositories/lessons/lessons_repository.dart";

class LessonsPageState {
  LessonsPageState({
    required this.categoriesByTitle,
    required this.lessons,
    required this.keywords,
  });

  final List<(String, List<Lesson>)> categoriesByTitle;
  final List<Lesson> lessons;
  final Set<String> keywords;

  /// This is necessary as to avoid the equality check in emit.
  LessonsPageState update() {
    return LessonsPageState(
      categoriesByTitle: categoriesByTitle,
      lessons: lessons,
      keywords: keywords,
    );
  }
}
