// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.lessons_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Lesson _$LessonFromJson(Map<String, dynamic> json) => _Lesson(
      id: json['id'] as String,
      category: json['category'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      color: colorFromJson(json['color'] as String),
      units: (json['units'] as List<dynamic>).map((e) => e as String).toList(),
      chapters: (json['chapters'] as List<dynamic>)
          .map((e) => Chapter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LessonToJson(_Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'name': instance.name,
      'description': instance.description,
      'color': colorToJson(instance.color),
      'units': instance.units,
      'chapters': instance.chapters,
    };
