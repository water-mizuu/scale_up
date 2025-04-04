import "dart:async";
import "dart:convert";

import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:scale_up/data/repositories/lessons/expression.lessons_repository.dart";
import "package:scale_up/data/repositories/lessons/expression_parser.dart";
import "package:scale_up/data/repositories/lessons/lesson.lessons_repository.dart";
import "package:scale_up/data/repositories/lessons/unit.lessons_repository.dart";
import "package:scale_up/data/repositories/lessons/unit_group.lessons_repository.dart";

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
