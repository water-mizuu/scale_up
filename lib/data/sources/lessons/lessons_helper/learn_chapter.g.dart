// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LearnChapter _$LearnChapterFromJson(Map<String, dynamic> json) =>
    _LearnChapter(
      type: json['type'] as String,
      name: json['name'] as String,
      units: (json['units'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$LearnChapterToJson(_LearnChapter instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'units': instance.units,
    };
