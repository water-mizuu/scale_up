import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository/conversion.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository/unit.dart";

part "unit_group.freezed.dart";
part "unit_group.g.dart";

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
