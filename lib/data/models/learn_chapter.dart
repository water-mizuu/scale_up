import "package:freezed_annotation/freezed_annotation.dart";

part "learn_chapter.freezed.dart";
part "learn_chapter.g.dart";

@freezed
abstract class LearnChapter with _$LearnChapter {
  const factory LearnChapter({
    required String type,
    required String name,
    required List<String> units,
  }) = _LearnChapter;
  const LearnChapter._();

  factory LearnChapter.fromJson(Map<String, dynamic> json) => _$LearnChapterFromJson(json);
}
