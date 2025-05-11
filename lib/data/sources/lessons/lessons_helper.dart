import "dart:async";

import "package:collection/collection.dart";
import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:scale_up/data/models/conversion.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/data/models/template.dart";
import "package:scale_up/data/models/unit.dart";
import "package:scale_up/data/models/unit_group.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/numerical_expression.dart";
import "package:scale_up/data/sources/lessons/parsers/numerical_expression_parser.dart";
import "package:yaml/yaml.dart";

class LessonsHelper {
  LessonsHelper._();

  static Future<LessonsHelper> createAsync() async {
    var lessonsHelper = LessonsHelper._();
    await lessonsHelper.initialize();

    return lessonsHelper;
  }

  bool hasLoaded = false;
  final List<Template> _templates = [];
  final List<Lesson> _lessons = [];
  final List<UnitGroup> _unitGroups = [];

  List<Lesson> get lessons {
    return _lessons;
  }

  /// This casts a yaml object to a JSON style object.
  /// This is needed as YAML maps are typed as Map\<dynamic, dynamic\>,
  /// but we need them to be Map\<String, dynamic> for JSON parsing.
  Object? deepCastYaml(Object? yaml) {
    if (yaml is YamlList) {
      return yaml.map((e) => deepCastYaml(e)).toList();
    } else if (yaml is YamlMap) {
      return yaml.map((key, value) => MapEntry(key.toString(), deepCastYaml(value)));
    } else {
      return yaml;
    }
  }

  Object? yamlDecode(String object) {
    var yaml = loadYaml(object) as YamlMap;

    return deepCastYaml(yaml);
  }

  Future<void> initialize() async {
    if (hasLoaded) return;

    // // Parse the JSON string into a Dart object

    var yamlString = await rootBundle.loadString("assets/lessons.yaml");
    var data = await compute(yamlDecode, yamlString) as Map<String, dynamic>;

    // Use the parsed data
    var {
      "templates": List<dynamic> templates,
      "lessons": List<dynamic> lessons, //
      "units_present": List<dynamic> unitsPresent,
    } = data;

    var templateList = templates.cast<Map<String, dynamic>>().map(Template.fromJson).toList();
    _templates
      ..clear()
      ..addAll(templateList);

    var lessonList = lessons.cast<Map<String, dynamic>>().map(Lesson.fromJson).toList();

    _lessons
      ..clear()
      ..addAll(lessonList);

    // Load the units
    var unitGroups = unitsPresent.cast<Map<String, dynamic>>().map(UnitGroup.fromJson).toList();

    _unitGroups
      ..clear()
      ..addAll(unitGroups);

    hasLoaded = true;
  }

  Lesson? getLesson(String id) {
    return _lessons.where((lesson) => lesson.id == id).firstOrNull;
  }

  UnitGroup? getUnitGroup(String type) {
    return _unitGroups //
        .where((group) => group.type == type)
        .firstOrNull;
  }

  UnitGroup? getLocalUnitGroup(String type, List<String> units) {
    var unitGroup = getUnitGroup(type);
    if (unitGroup == null) return null;

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

  UnitGroup? getExtendedUnitGroup(String type) {
    var unitGroup = getUnitGroup(type);
    if (unitGroup == null) return null;

    var (_, graph) = _computeCanonicalConversionGraph(unitGroup);
    var conversions = [
      for (var MapEntry(key: from, value: rest) in graph.entries)
        for (var MapEntry(key: to, value: formula) in rest.entries)
          Conversion(from: from.id, to: to.id, formula: formula),
    ];

    return unitGroup.copyWith(conversions: conversions);
  }

  UnitGroup? getLocalExtendedUnitGroup(String type, List<String> units) {
    var unitGroup = getExtendedUnitGroup(type);
    if (unitGroup == null) return null;

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

  final Map<String, Unit?> _unitMap = {};
  Unit? getUnit(String unitGroup, String id) {
    if (_unitMap.containsKey(id)) {
      return _unitMap[id];
    }

    return _unitGroups //
        .where((group) => group.type == unitGroup)
        .expand((group) => group.units)
        .where((unit) => unit.id == id)
        .firstOrNull;
  }

  Template? getTemplate(String type) {
    return _templates //
        .where((template) => template.type == type)
        .firstOrNull;
  }

  List<((Unit, Unit), NumericalExpression)>? getConversionPathFor(
    Unit from,
    Unit to, [
    UnitGroup? localUnitGroup,
  ]) {
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

    return _computeConversionFor(unitGroup, from, to, localUnitGroup);
  }

  UnitGroup? getUnitGroupForUnits(List<Unit> allUnits) {
    Set<UnitGroup> candidates = _unitGroups.toSet();

    for (var unit in allUnits) {
      candidates.removeWhere((g) => !g.units.contains(unit));
    }

    return candidates.first;
  }

  final Expando<(Map<String, Unit>, Map<Unit, Map<Unit, NumericalExpression>>)>
  _computedCanonicalConversionGraph = Expando();

  /// The canonical conversion graph is an incomplete graph
  ///   which is derived from the defined conversions and their inverses.
  (Map<String, Unit>, Map<Unit, Map<Unit, NumericalExpression>>) _computeCanonicalConversionGraph(
    UnitGroup group,
  ) {
    if (_computedCanonicalConversionGraph[group] case var result?) {
      return result;
    }

    var unitMap = {for (var unit in group.units) unit.id: unit};
    var conversionGraph = <Unit, Map<Unit, NumericalExpression>>{};
    for (var conversion in group.conversions) {
      var Conversion(:from, :to, :formula) = conversion;

      var lhs = const VariableExpression("from") as NumericalExpression;
      var rhs = formula;

      conversionGraph.putIfAbsent(unitMap[from]!, Map.new)[unitMap[to]!] = rhs;
      (lhs, rhs) = NumericalExpression.inverse(lhs as VariableExpression, rhs);
      conversionGraph.putIfAbsent(unitMap[to]!, Map.new)[unitMap[from]!] = lhs;
    }

    return _computedCanonicalConversionGraph[group] = (unitMap, conversionGraph);
  }

  /// This gives a conversion path from [start] to [end] in the form of a list of expressions.
  /// The conversion path is computed using a breadth-first search (BFS) algorithm.
  List<((Unit, Unit), NumericalExpression)>? _computeConversionFor(
    UnitGroup group,
    Unit start,
    Unit end, [
    UnitGroup? localUnitGroup,
  ]) {
    var (unitMap, conversionGraph) = _computeCanonicalConversionGraph(group);
    var parent = <Unit, Unit>{};
    var visited = <Unit>{start};
    var queue = PriorityQueue<Unit>((a, b) {
      /// We want to prioritize the local unit group.
      if (localUnitGroup == null) {
        return 0;
      }

      var isAIncludedInLocalGroup = localUnitGroup.units.contains(a);
      var isBIncludedInLocalGroup = localUnitGroup.units.contains(b);
      if (isAIncludedInLocalGroup && isBIncludedInLocalGroup) {
        return 0;
      } else if (isAIncludedInLocalGroup) {
        return -1;
      } else if (isBIncludedInLocalGroup) {
        return 1;
      }
      return 0;
    })..add(start);

    /// BFS.
    while (queue.isNotEmpty) {
      var current = queue.removeFirst();
      if (current == end) {
        break;
      }

      if (conversionGraph[current] case var neighbors?) {
        for (var neighbor in neighbors.keys) {
          if (visited.add(neighbor)) {
            parent[neighbor] = current;
            queue.add(neighbor);
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

    var conversions = <((Unit, Unit), NumericalExpression)>[];
    for (var i = 0; i < path.length - 1; ++i) {
      var from = path[i];
      var to = path[i + 1];
      var conversion = conversionGraph[from]![to]!;
      conversions.add(((from, to), conversion));
    }

    return conversions;
  }
}

NumericalExpression expressionFromJson(String json) {
  var parser = NumericalExpressionParser();

  if (parser.parse(json) case NumericalExpression expression) {
    return expression;
  }

  throw FormatException("Invalid expression format: '$json'");
}

String expressionToJson(NumericalExpression expression) => expression.toString();
