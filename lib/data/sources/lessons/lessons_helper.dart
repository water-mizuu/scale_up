import "dart:async";
import "dart:collection";
import "dart:convert";

import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:scale_up/data/sources/lessons/expression_parser.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/conversion.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/expression.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/lesson.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/unit.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/unit_group.dart";

class LessonsHelper {
  LessonsHelper();

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

    var {"lessons": List<dynamic> lessons, "units_present": List<dynamic> unitsPresent} = data;

    var lessonList =
        lessons //
            .map((lesson) => Lesson.fromJson(lesson as Map<String, dynamic>))
            .toList();

    _lessons
      ..clear()
      ..addAll(lessonList);

    // Load the units
    var unitGroups =
        unitsPresent //
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

  Future<UnitGroup?> getExtendedUnitGroup(String type) async {
    var unitGroup = await getUnitGroup(type);
    if (unitGroup == null) {
      return null;
    }

    var (_, graph) = _computeCanonicalConversionGraph(unitGroup);
    var conversions = [
      for (var MapEntry(key: from, value: rest0) in graph.entries)
        for (var MapEntry(key: to, value: formula) in rest0.entries)
          Conversion(from: from.id, to: to.id, formula: formula),
    ];

    return unitGroup.copyWith(conversions: conversions);
  }

  Future<Unit?> getUnit(String id) async {
    await _init.future;

    return _unitGroups //
        .expand((g) => g.units)
        .where((unit) => unit.id == id)
        .firstOrNull;
  }

  /// The canonical conversion graph is an incomplete graph
  ///   which is derived from the defined conversions and their inverses.
  (Map<String, Unit>, Map<Unit, Map<Unit, Expression>>) _computeCanonicalConversionGraph(
    UnitGroup group,
  ) {
    var unitMap = {for (var unit in group.units) unit.id: unit};
    var conversionGraph = <Unit, Map<Unit, Expression>>{};
    for (var conversion in group.conversions) {
      var Conversion(:from, :to, :formula) = conversion;

      var lhs = VariableExpression("from") as Expression;
      var rhs = formula;

      conversionGraph.putIfAbsent(unitMap[from]!, Map.new)[unitMap[to]!] = rhs;
      (lhs, rhs) = Expression.inverse(lhs as VariableExpression, rhs);
      conversionGraph.putIfAbsent(unitMap[to]!, Map.new)[unitMap[from]!] = lhs;
    }

    return (unitMap, conversionGraph);
  }

  Future<List<Expression>?> _computeConversionFor(UnitGroup group, Unit start, Unit end) async {
    await _init.future;

    var (unitMap, conversionGraph) = _computeCanonicalConversionGraph(group);
    var parent = <Unit, Unit>{};
    var visited = <Unit>{};
    var queue = Queue<Unit>()..add(start);

    /// BFS.
    while (queue.isNotEmpty) {
      var current = queue.removeFirst();
      if (current == end) {
        break;
      }

      visited.add(current);

      if (conversionGraph[current] case var neighbors?) {
        for (var neighbor in neighbors.keys) {
          if (!visited.contains(neighbor)) {
            parent[neighbor] = current;
            queue.addLast(neighbor);
          }
        }
      }
    }

    if (!parent.containsKey(end)) {
      if (kDebugMode) {
        throw UnsupportedError("No conversion path found from $start to $end");
      }

      return null;
    }

    var path = <Unit>[];
    var current = end;
    while (current != start) {
      path.add(current);
      current = parent[current]!;
    }
    path.add(start);
    path = path.reversed.toList();

    var conversions = <Expression>[];
    for (var i = 0; i < path.length - 1; ++i) {
      var from = path[i];
      var to = path[i + 1];
      var conversion = conversionGraph[from]![to]!;
      conversions.add(conversion);
    }

    return conversions;
  }

  Future<List<Expression>?> getConversionPathFor(Unit from, Unit to) async {
    await _init.future;

    var unitGroup =
        _unitGroups //
            .where(
              (group) =>
                  group.units.any((unit) => unit.id == from.id) &&
                  group.units.any((unit) => unit.id == to.id),
            )
            .firstOrNull;

    if (unitGroup == null) {
      throw Exception("Unit group not found for units $from and $to");
    }

    return _computeConversionFor(unitGroup, from, to);
  }
}

String colorToJson(Color color) {
  var values = [(color.r * 255).floor(), (color.g * 255).floor(), (color.b * 255).floor()];
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
