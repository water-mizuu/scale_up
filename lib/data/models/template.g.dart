// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Template _$TemplateFromJson(Map<String, dynamic> json) => _Template(
  type: json['type'] as String,
  parts:
      (json['parts'] as List<dynamic>)
          .map((e) => TemplatePart.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$TemplateToJson(_Template instance) => <String, dynamic>{
  'type': instance.type,
  'parts': instance.parts,
};
