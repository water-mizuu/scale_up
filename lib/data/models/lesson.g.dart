// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Lesson _$LessonFromJson(Map<String, dynamic> json) => _Lesson(
  id: json['id'] as String,
  category: json['category'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  unitsType: json['units_type'] as String,
  color: _colorFromJson(json['color'] as String),
  units: (json['units'] as List<dynamic>).map((e) => e as String).toList(),
  learnChapters:
      (json['learn'] as List<dynamic>)
          .map((e) => LearnChapter.fromJson(e as Map<String, dynamic>))
          .toList(),
  practiceChapters:
      (json['practice'] as List<dynamic>)
          .map((e) => PracticeChapter.fromJson(e as Map<String, dynamic>))
          .toList(),
  icon: json['icon'] as String,
);

Map<String, dynamic> _$LessonToJson(_Lesson instance) => <String, dynamic>{
  'id': instance.id,
  'category': instance.category,
  'name': instance.name,
  'description': instance.description,
  'units_type': instance.unitsType,
  'units': instance.units,
  'learn': instance.learnChapters,
  'practice': instance.practiceChapters,
  'icon': instance.icon,
};
