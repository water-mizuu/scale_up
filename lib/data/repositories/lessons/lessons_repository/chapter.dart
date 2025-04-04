import "package:freezed_annotation/freezed_annotation.dart";

part "chapter.freezed.dart";
part "chapter.g.dart";

@freezed
abstract class Chapter with _$Chapter {
  const factory Chapter({
    required String name,
    @JsonKey(name: "question_count") required int questionCount,
    required List<String> units,
  }) = _Chapter;

  factory Chapter.fromJson(Map<String, dynamic> json) => _$ChapterFromJson(json);
}
