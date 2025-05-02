import "dart:math" show Random;

import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/sources/lessons/parsers/template_parser.dart";

part "template_part.freezed.dart";
part "template_part.g.dart";

@freezed
abstract class TemplatePart with _$TemplatePart {
  const TemplatePart._();
  const factory TemplatePart({required String type, required List<String> variants}) =
      _TemplatePart;

  factory TemplatePart.fromJson(Map<String, dynamic> json) => _$TemplatePartFromJson(json);

  static final templateParser = TemplateParser();

  String generateRandom(Map<String, String> variables) {
    var random = Random();
    var index = random.nextInt(variants.length);
    var chosen = variants[index];
    var parsed = templateParser.parse(chosen);
    if (parsed == null) {
      if (kDebugMode) {
        print("Failed to parse text: ${templateParser.reportFailures()}");
      }

      return chosen;
    }
    print(parsed);

    return parsed.evaluate(variables);
  }
}
