import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/expression.dart";

part "conversion.freezed.dart";
part "conversion.g.dart";

@freezed
abstract class Conversion with _$Conversion {
  const factory Conversion({
    required String from,
    required String to,
    @JsonKey(toJson: expressionToJson, fromJson: expressionFromJson) required Expression formula,
  }) = _Conversion;

  factory Conversion.fromJson(Map<String, dynamic> json) => _$ConversionFromJson(json);
}
