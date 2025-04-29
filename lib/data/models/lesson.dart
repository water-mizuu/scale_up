import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/models/learn_chapter.dart";
import "package:scale_up/data/models/practice_chapter.dart";
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
    @JsonKey(includeToJson: false, fromJson: _colorFromJson) required Color color,
    required List<String> units,
    @JsonKey(name: "learn") required List<LearnChapter> learnChapters,
    @JsonKey(name: "practice") required List<PracticeChapter> practiceChapters,
  }) = _Lesson;

  const Lesson._();
  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

  static final Expando<HSLColor> _hslExpando = Expando<HSLColor>();
  HSLColor get hslColor => _hslExpando[this] ??= HSLColor.fromColor(color);
  Color get foregroundColor => color.contrastingTextColor();

  int get chapterCount => learnChapters.length + practiceChapters.length;
}

Color _colorFromJson(String hex) {
  var regexp = RegExp(r"\#([A-Fa-f0-9]{2})([A-Fa-f0-9]{2})([A-Fa-f0-9]{2})");
  var parsed = regexp.firstMatch(hex);
  if (parsed == null) throw Error();
  var red = int.parse(parsed.group(1)!, radix: 16);
  var green = int.parse(parsed.group(2)!, radix: 16);
  var blue = int.parse(parsed.group(3)!, radix: 16);

  return Color.fromARGB(255, red, green, blue);
}
