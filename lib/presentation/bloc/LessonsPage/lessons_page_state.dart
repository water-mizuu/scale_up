class LessonsPageState {
  const LessonsPageState({
    required this.keywords,
  });

  final Set<String> keywords;

  LessonsPageState copyWith({
    Set<String>? keywords,
  }) {
    return LessonsPageState(
      keywords: keywords ?? this.keywords,
    );
  }
}
