// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TemplatePart _$TemplatePartFromJson(Map<String, dynamic> json) =>
    _TemplatePart(
      type: json['type'] as String,
      variants:
          (json['variants'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TemplatePartToJson(_TemplatePart instance) =>
    <String, dynamic>{'type': instance.type, 'variants': instance.variants};
