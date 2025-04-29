import "package:freezed_annotation/freezed_annotation.dart";

part "practice_chapter.freezed.dart";
part "practice_chapter.g.dart";

@freezed
abstract class PracticeChapter with _$PracticeChapter {
  const factory PracticeChapter({
    required String name,
    @JsonKey(name: "question_count") required int questionCount,
    required List<String> units,
  }) = _PracticeChapter;

  factory PracticeChapter.fromJson(Map<String, dynamic> json) => _$PracticeChapterFromJson(json);
}
