// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PracticeChapter _$PracticeChapterFromJson(Map<String, dynamic> json) =>
    _PracticeChapter(
      name: json['name'] as String,
      questionCount: (json['question_count'] as num).toInt(),
      units: (json['units'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PracticeChapterToJson(_PracticeChapter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'question_count': instance.questionCount,
      'units': instance.units,
    };
