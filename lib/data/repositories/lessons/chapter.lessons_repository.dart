import "package:freezed_annotation/freezed_annotation.dart";

part "chapter.lessons_repository.freezed.dart";
part "chapter.lessons_repository.g.dart";

@freezed
abstract class Chapter with _$Chapter {
  const factory Chapter({
    required String name,
    @JsonKey(name: "question_count") required int questionCount,
    required List<String> units,
  }) = _Chapter;

  factory Chapter.fromJson(Map<String, dynamic> json) => _$ChapterFromJson(json);
}
