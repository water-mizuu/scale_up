import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/repositories/lessons/expression.lessons_repository.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository.dart";

part "conversion.lessons_repository.freezed.dart";
part "conversion.lessons_repository.g.dart";

@freezed
abstract class Conversion with _$Conversion {
  const factory Conversion({
    required String from,
    required String to,
    @JsonKey(toJson: expressionToJson, fromJson: expressionFromJson) required Expression formula,
  }) = _Conversion;

  factory Conversion.fromJson(Map<String, dynamic> json) => _$ConversionFromJson(json);
}
