// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expression _$ExpressionFromJson(Map<String, dynamic> json) => Expression(
      json['expression'] as String,
    );

Map<String, dynamic> _$ExpressionToJson(Expression instance) =>
    <String, dynamic>{
      'expression': instance.expression,
    };

_UnitGroup _$UnitGroupFromJson(Map<String, dynamic> json) => _UnitGroup(
      name: json['name'] as String,
      conversions: (json['conversions'] as List<dynamic>)
          .map((e) => Conversion.fromJson(e as Map<String, dynamic>))
          .toList(),
      units: (json['units'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UnitGroupToJson(_UnitGroup instance) =>
    <String, dynamic>{
      'name': instance.name,
      'conversions': instance.conversions,
      'units': instance.units,
    };

_Conversion _$ConversionFromJson(Map<String, dynamic> json) => _Conversion(
      from: json['from'] as String,
      to: json['to'] as String,
      formula: Expression.fromJson(json['formula'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConversionToJson(_Conversion instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'formula': instance.formula,
    };

_Lesson _$LessonFromJson(Map<String, dynamic> json) => _Lesson(
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
      'category': instance.category,
      'name': instance.name,
      'description': instance.description,
      'color': colorToJson(instance.color),
      'units': instance.units,
      'chapters': instance.chapters,
    };

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
