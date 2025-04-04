import "package:flutter/services.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository/chapter.dart";
import "package:scale_up/utils/color_luminance.dart";

part "lesson.freezed.dart";
part "lesson.g.dart";

@freezed
abstract class Lesson with _$Lesson {
  const factory Lesson({
    required String id,
    required String category,
    required String name,
    required String description,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson) required Color color,
    required List<String> units,
    required List<Chapter> chapters,
  }) = _Lesson;

  const Lesson._();
  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

  Color get foregroundColor => color.contrastingTextColor();
  int get questionCount => chapters.map((c) => c.questionCount).reduce((a, b) => a + b);
  int get chapterCount => chapters.length;
}
