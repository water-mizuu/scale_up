import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/learn_chapter.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/practice_chapter.dart";
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
    @JsonKey(name: "learn") required List<LearnChapter> learnChapters,
    @JsonKey(name: "practice") required List<PracticeChapter> practiceChapters,
  }) = _Lesson;

  const Lesson._();
  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

  static final Expando<HSLColor> _hslExpando = Expando<HSLColor>();
  static final Expando<Color> _colorExpando = Expando<Color>();

  Color get color => _colorExpando[this] ??= hslColor.toColor();
  HSLColor get hslColor {
    late var hash = Object.hashAll([id, category, name]);
    late var hue = (hash * 123456789.0) % 360;
    late var saturation = 0.65; // 65% saturation
    late var lightness = 0.30;

    return _hslExpando[this] ??= HSLColor.fromAHSL(1.0, hue, saturation, lightness);
  }

  Color get foregroundColor => color.contrastingTextColor();

}
