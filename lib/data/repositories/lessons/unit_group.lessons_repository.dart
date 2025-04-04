import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/repositories/lessons/conversion.lessons_repository.dart";
import "package:scale_up/data/repositories/lessons/unit.lessons_repository.dart";

part "unit_group.lessons_repository.freezed.dart";
part "unit_group.lessons_repository.g.dart";

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
