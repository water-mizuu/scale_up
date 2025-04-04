// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Chapter _$ChapterFromJson(Map<String, dynamic> json) => _Chapter(
      name: json['name'] as String,
      questionCount: (json['question_count'] as num).toInt(),
      units: (json['units'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ChapterToJson(_Chapter instance) => <String, dynamic>{
      'name': instance.name,
      'question_count': instance.questionCount,
      'units': instance.units,
    };
