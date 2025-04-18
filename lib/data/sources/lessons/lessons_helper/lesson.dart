import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/chapter.dart";
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
    @JsonKey(name: "units_type") required String unitsType,
    required List<String> units,
    required List<Chapter> chapters,
  }) = _Lesson;

  const Lesson._();
  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

  static final Expando<Color> _colorExpando = Expando<Color>();
  Color get color {
    late var hash = Object.hashAll([id, category, name]);
    late var hue = (hash * 123456789.0) % 360;
    late var saturation = 0.65; // 65% saturation
    late var lightness = 0.30;

    late var color = HSLColor.fromAHSL(1.0, hue, saturation, lightness);
    late var rgbColor = color.toColor();

    return _colorExpando[this] ??= rgbColor;
  }

  Color get foregroundColor => color.contrastingTextColor();

  int get questionCount => chapters.map((c) => c.questionCount).reduce((a, b) => a + b);
  int get chapterCount => chapters.length;
}
