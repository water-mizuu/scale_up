// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Conversion _$ConversionFromJson(Map<String, dynamic> json) => _Conversion(
  from: json['from'] as String,
  to: json['to'] as String,
  formula: expressionFromJson(json['formula'] as String),
);

Map<String, dynamic> _$ConversionToJson(_Conversion instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'formula': expressionToJson(instance.formula),
    };
