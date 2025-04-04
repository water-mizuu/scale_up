import "package:freezed_annotation/freezed_annotation.dart";

part "unit.lessons_repository.freezed.dart";
part "unit.lessons_repository.g.dart";

@freezed
abstract class Unit with _$Unit {
  const factory Unit({
    required String id,
    required String shortcut,
  }) = _Unit;

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);
}
