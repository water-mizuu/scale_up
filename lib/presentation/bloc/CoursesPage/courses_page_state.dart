class CoursesPageState {
  const CoursesPageState({
    required this.keywords,
  });

  final Set<String> keywords;

  CoursesPageState copyWith({
    Set<String>? keywords,
  }) {
    return CoursesPageState(
      keywords: keywords ?? this.keywords,
    );
  }
}
