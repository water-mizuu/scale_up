import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/models/template_part.dart";

part "template.freezed.dart";
part "template.g.dart";

@freezed
abstract class Template with _$Template {
  const Template._();
  const factory Template({
    required String type,
    required List<TemplatePart> parts, //
  }) = _Template;

  factory Template.fromJson(Map<String, dynamic> json) => _$TemplateFromJson(json);

  Map<String, String> generateRandom(Map<String, String> variables) {
    var completedParts = <String, String>{};
    for (var part in parts) {
      completedParts[part.type] = part.generateRandom(variables);
    }
    return completedParts;
  }
}
