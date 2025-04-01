import "dart:convert";

import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "lesson_repository.freezed.dart";
part "lesson_repository.g.dart";

class LessonRepository {
  LessonRepository();

  final List<Lesson> _lessons = [];
  List<Lesson> get lessons => _lessons;

  Future<void> initialize() async {
    // Initialize the repository, if needed
    var jsonString = await rootBundle.loadString("assets/lessons.json");
    // Parse the JSON string into a Dart object
    var data = await compute(jsonDecode, jsonString) as Map<String, dynamic>;
    // Use the parsed data
    if (kDebugMode) {
      // print(data);
    }
    var lessons = data["lessons"] as List<dynamic>;
    // Convert the list of lessons to a list of Lesson objects
    var lessonList = lessons //
        .map((lesson) => Lesson.fromJson(lesson as Map<String, dynamic>))
        .toList();

    _lessons
      ..clear()
      ..addAll(lessonList);
  }
}

@freezed
abstract class UnitGroup with _$UnitGroup {
  const factory UnitGroup({
    required String name,
    required List<Conversion> conversions,
    required List<String> units,
  }) = _UnitGroup;

  factory UnitGroup.fromJson(Map<String, dynamic> json) => _$UnitGroupFromJson(json);
}

@freezed
abstract class Conversion with _$Conversion {
  const factory Conversion({
    required String from,
    required String to,
    required Expression formula,
  }) = _Conversion;

  factory Conversion.fromJson(Map<String, dynamic> json) => _$ConversionFromJson(json);
}

@JsonSerializable()
class Expression {
  final String expression;

  Expression(this.expression);

  factory Expression.fromJson(Map<String, dynamic> json) => _$ExpressionFromJson(json);

  Map<String, dynamic> toJson() => _$ExpressionToJson(this);
}

@freezed
abstract class Lesson with _$Lesson {
  const factory Lesson({
    required String category,
    required String name,
    required String description,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson) required Color color,
    required List<String> units,
    required List<Chapter> chapters,
  }) = _Lesson;

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
}

@freezed
abstract class Chapter with _$Chapter {
  const factory Chapter({
    required String name,
    @JsonKey(name: "question_count") required int questionCount,
    required List<String> units,
  }) = _Chapter;

  factory Chapter.fromJson(Map<String, dynamic> json) => _$ChapterFromJson(json);
}

String colorToJson(Color color) {
  var values = [
    (color.r * 255).floor(),
    (color.g * 255).floor(),
    (color.b * 255).floor(),
  ];
  var joined = values.map((v) => v.toRadixString(16).padLeft(2, "0")).join();

  return "#$joined";
}

Color colorFromJson(String json) {
  var regex = RegExp(r"^#([0-9a-fA-F]{6})$");
  var match = regex.firstMatch(json);

  if (match == null) {
    throw FormatException("Invalid color format");
  }

  var hex = match.group(1)!;
  var r = int.parse(hex.substring(0, 2), radix: 16);
  var g = int.parse(hex.substring(2, 4), radix: 16);
  var b = int.parse(hex.substring(4, 6), radix: 16);

  return Color.fromARGB(255, r, g, b);
}
