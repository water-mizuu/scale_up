import "dart:async";
import "dart:convert";

import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:parser_combinator/parser_combinator.dart";
import "package:scale_up/data/repositories/lessons/expression.lessons_repository.dart";
import "package:scale_up/data/repositories/lessons/expression_parser.dart";
import "package:scale_up/utils/color_luminance.dart";

part "lessons_repository.freezed.dart";
part "lessons_repository.g.dart";

class LessonsRepository {
  LessonsRepository();

  final Completer<void> _init = Completer<void>();
  final List<Lesson> _lessons = [];

  final List<UnitGroup> _unitGroups = [];

  Future<List<Lesson>> get lessons async {
    await _init.future;
    return _lessons;
  }

  Future<void> initialize() async {
    // Initialize the repository, if needed
    var jsonString = await rootBundle.loadString("assets/lessons.json");
    // Parse the JSON string into a Dart object
    var data = await compute(jsonDecode, jsonString) as Map<String, dynamic>;
    // Use the parsed data
    if (kDebugMode) {
      // print(data);
    }

    var {
      "lessons": lessons as List<dynamic>,
      "units_present": unitsPresent as List<dynamic>,
    } = data;

    var lessonList = lessons //
        .map((lesson) => Lesson.fromJson(lesson as Map<String, dynamic>))
        .toList();

    _lessons
      ..clear()
      ..addAll(lessonList);

    // Load the units
    var unitGroups = unitsPresent //
        .map((unitGroup) => UnitGroup.fromJson(unitGroup as Map<String, dynamic>))
        .toList();

    _unitGroups
      ..clear()
      ..addAll(unitGroups);

    _init.complete();
  }

  Future<Lesson?> getLesson(String id) async {
    await _init.future;

    return _lessons.where((lesson) => lesson.id == id).firstOrNull;
  }

  Future<UnitGroup?> getUnitGroup(String type) async {
    await _init.future;

    return _unitGroups //
        .where((group) => group.type == type)
        .firstOrNull;
  }

  Future<Unit?> getUnit(String id) async {
    await _init.future;

    return _unitGroups //
        .expand((g) => g.units)
        .where((unit) => unit.id == id)
        .firstOrNull;
  }
}

@freezed
abstract class UnitGroup with _$UnitGroup {
  const factory UnitGroup({
    required String type,
    required List<Conversion> conversions,
    required List<Unit> units,
  }) = _UnitGroup;
  const UnitGroup._();

  factory UnitGroup.fromJson(Map<String, dynamic> json) => _$UnitGroupFromJson(json);
}

@freezed
abstract class Conversion with _$Conversion {
  const factory Conversion({
    required String from,
    required String to,
    @JsonKey(toJson: expressionToJson, fromJson: expressionFromJson) required Expression formula,
  }) = _Conversion;

  factory Conversion.fromJson(Map<String, dynamic> json) => _$ConversionFromJson(json);
}

@freezed
abstract class Unit with _$Unit {
  const factory Unit({
    required String id,
    required String shortcut,
  }) = _Unit;

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);
}

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

typedef P = Parser<Expression>;

Expression expressionFromJson(String json) {
  var parser = ExpressionParser();

  if (parser.parse(json) case Expression expression) {
    return expression;
  }

  throw FormatException("Invalid expression format: '$json'");
}

String expressionToJson(Expression expression) {
  throw Error();
}
