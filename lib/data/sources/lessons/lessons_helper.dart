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
  LessonsHelper._();

  static Future<LessonsHelper> createAsync() async {
    var lessonsHelper = LessonsHelper._();
    await lessonsHelper.initialize();

    return lessonsHelper;
  }

  final List<Lesson> _lessons = [];

  final List<UnitGroup> _unitGroups = [];

  List<Lesson> get lessons {
    return _lessons;
  }

  Future<void> initialize() async {
    var jsonString = await rootBundle.loadString("assets/lessons.json");
    // Parse the JSON string into a Dart object
    var data = await compute(jsonDecode, jsonString) as Map<String, dynamic>;
    // Use the parsed data
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
  }

  Lesson? getLesson(String id) {
    return _lessons.where((lesson) => lesson.id == id).firstOrNull;
  }

  UnitGroup? getUnitGroup(String type) {
    return _unitGroups //
        .where((group) => group.type == type)
        .firstOrNull;
  }

  UnitGroup? getExtendedUnitGroup(String type) {
    var unitGroup = getUnitGroup(type);
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

  UnitGroup? getLocalExtendedUnitGroup(String type, List<String> units) {
    var unitGroup = getExtendedUnitGroup(type);
    if (unitGroup == null) {
      return null;
    }

    return unitGroup.copyWith(
      units: [
        for (var unit in units)
          unitGroup.units.firstWhere((unitGroupUnit) => unitGroupUnit.id == unit),
      ],
      conversions: [
        for (var conversion in unitGroup.conversions)
          if (units.contains(conversion.from) && units.contains(conversion.to)) conversion,
      ],
    );
  }

  Unit? getUnit(String id) {
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

  /// This gives a conversion path from [start] to [end] in the form of a list of expressions.
  /// The conversion path is computed using a breadth-first search (BFS) algorithm.
  List<((Unit, Unit), Expression)>? _computeConversionFor(UnitGroup group, Unit start, Unit end) {
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

    var conversions = <((Unit, Unit), Expression)>[];
    for (var i = 0; i < path.length - 1; ++i) {
      var from = path[i];
      var to = path[i + 1];
      var conversion = conversionGraph[from]![to]!;
      conversions.add(((from, to), conversion));
    }

    return conversions;
  }

  List<((Unit, Unit), Expression)>? getConversionPathFor(Unit from, Unit to) {
    var unitGroup =
        _unitGroups //
            .where((group) => group.units.contains(from) && group.units.contains(to))
            .firstOrNull;

    if (unitGroup == null) {
      if (kDebugMode) {
        throw UnsupportedError("No unit group found for units $from and $to");
      }
      return null;
    }

    return _computeConversionFor(unitGroup, from, to);
  }
}

Expression expressionFromJson(String json) {
  var parser = ExpressionParser();

  if (parser.parse(json) case Expression expression) {
    return expression;
  }

  throw FormatException("Invalid expression format: '$json'");
}

String expressionToJson(Expression expression) => expression.toString();
