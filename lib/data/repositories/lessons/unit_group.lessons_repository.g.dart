// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_group.lessons_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UnitGroup _$UnitGroupFromJson(Map<String, dynamic> json) => _UnitGroup(
      type: json['type'] as String,
      conversions: (json['conversions'] as List<dynamic>)
          .map((e) => Conversion.fromJson(e as Map<String, dynamic>))
          .toList(),
      units: (json['units'] as List<dynamic>)
          .map((e) => Unit.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UnitGroupToJson(_UnitGroup instance) =>
    <String, dynamic>{
      'type': instance.type,
      'conversions': instance.conversions,
      'units': instance.units,
    };
