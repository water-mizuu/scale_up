import "package:freezed_annotation/freezed_annotation.dart";

part "unit.freezed.dart";
part "unit.g.dart";

@freezed
abstract class Unit with _$Unit {
  const Unit._();
  const factory Unit({required String id, required String shortcut, String? display}) = _Unit;

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  String get name => id //
      .split("_")
      .map((e) => e[0].toUpperCase() + e.split("").sublist(1).join(""))
      .join(" ");

  @override
  String toString() => shortcut;
}
