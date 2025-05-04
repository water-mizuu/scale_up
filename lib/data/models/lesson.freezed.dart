// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Lesson {

 String get id; String get category; String get name; String get description;@JsonKey(name: "units_type") String get unitsType;@JsonKey(includeToJson: false, fromJson: _colorFromJson) Color get color; List<String> get units;@JsonKey(name: "learn") List<LearnChapter> get learnChapters;@JsonKey(name: "practice") List<PracticeChapter> get practiceChapters; String get icon;
/// Create a copy of Lesson
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonCopyWith<Lesson> get copyWith => _$LessonCopyWithImpl<Lesson>(this as Lesson, _$identity);

  /// Serializes this Lesson to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Lesson&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.unitsType, unitsType) || other.unitsType == unitsType)&&(identical(other.color, color) || other.color == color)&&const DeepCollectionEquality().equals(other.units, units)&&const DeepCollectionEquality().equals(other.learnChapters, learnChapters)&&const DeepCollectionEquality().equals(other.practiceChapters, practiceChapters)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,name,description,unitsType,color,const DeepCollectionEquality().hash(units),const DeepCollectionEquality().hash(learnChapters),const DeepCollectionEquality().hash(practiceChapters),icon);

@override
String toString() {
  return 'Lesson(id: $id, category: $category, name: $name, description: $description, unitsType: $unitsType, color: $color, units: $units, learnChapters: $learnChapters, practiceChapters: $practiceChapters, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $LessonCopyWith<$Res>  {
  factory $LessonCopyWith(Lesson value, $Res Function(Lesson) _then) = _$LessonCopyWithImpl;
@useResult
$Res call({
 String id, String category, String name, String description,@JsonKey(name: "units_type") String unitsType,@JsonKey(includeToJson: false, fromJson: _colorFromJson) Color color, List<String> units,@JsonKey(name: "learn") List<LearnChapter> learnChapters,@JsonKey(name: "practice") List<PracticeChapter> practiceChapters, String icon
});




}
/// @nodoc
class _$LessonCopyWithImpl<$Res>
    implements $LessonCopyWith<$Res> {
  _$LessonCopyWithImpl(this._self, this._then);

  final Lesson _self;
  final $Res Function(Lesson) _then;

/// Create a copy of Lesson
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? category = null,Object? name = null,Object? description = null,Object? unitsType = null,Object? color = null,Object? units = null,Object? learnChapters = null,Object? practiceChapters = null,Object? icon = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,unitsType: null == unitsType ? _self.unitsType : unitsType // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,units: null == units ? _self.units : units // ignore: cast_nullable_to_non_nullable
as List<String>,learnChapters: null == learnChapters ? _self.learnChapters : learnChapters // ignore: cast_nullable_to_non_nullable
as List<LearnChapter>,practiceChapters: null == practiceChapters ? _self.practiceChapters : practiceChapters // ignore: cast_nullable_to_non_nullable
as List<PracticeChapter>,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Lesson extends Lesson {
  const _Lesson({required this.id, required this.category, required this.name, required this.description, @JsonKey(name: "units_type") required this.unitsType, @JsonKey(includeToJson: false, fromJson: _colorFromJson) required this.color, required final  List<String> units, @JsonKey(name: "learn") required final  List<LearnChapter> learnChapters, @JsonKey(name: "practice") required final  List<PracticeChapter> practiceChapters, required this.icon}): _units = units,_learnChapters = learnChapters,_practiceChapters = practiceChapters,super._();
  factory _Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

@override final  String id;
@override final  String category;
@override final  String name;
@override final  String description;
@override@JsonKey(name: "units_type") final  String unitsType;
@override@JsonKey(includeToJson: false, fromJson: _colorFromJson) final  Color color;
 final  List<String> _units;
@override List<String> get units {
  if (_units is EqualUnmodifiableListView) return _units;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_units);
}

 final  List<LearnChapter> _learnChapters;
@override@JsonKey(name: "learn") List<LearnChapter> get learnChapters {
  if (_learnChapters is EqualUnmodifiableListView) return _learnChapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_learnChapters);
}

 final  List<PracticeChapter> _practiceChapters;
@override@JsonKey(name: "practice") List<PracticeChapter> get practiceChapters {
  if (_practiceChapters is EqualUnmodifiableListView) return _practiceChapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_practiceChapters);
}

@override final  String icon;

/// Create a copy of Lesson
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonCopyWith<_Lesson> get copyWith => __$LessonCopyWithImpl<_Lesson>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LessonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Lesson&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.unitsType, unitsType) || other.unitsType == unitsType)&&(identical(other.color, color) || other.color == color)&&const DeepCollectionEquality().equals(other._units, _units)&&const DeepCollectionEquality().equals(other._learnChapters, _learnChapters)&&const DeepCollectionEquality().equals(other._practiceChapters, _practiceChapters)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,name,description,unitsType,color,const DeepCollectionEquality().hash(_units),const DeepCollectionEquality().hash(_learnChapters),const DeepCollectionEquality().hash(_practiceChapters),icon);

@override
String toString() {
  return 'Lesson(id: $id, category: $category, name: $name, description: $description, unitsType: $unitsType, color: $color, units: $units, learnChapters: $learnChapters, practiceChapters: $practiceChapters, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$LessonCopyWith<$Res> implements $LessonCopyWith<$Res> {
  factory _$LessonCopyWith(_Lesson value, $Res Function(_Lesson) _then) = __$LessonCopyWithImpl;
@override @useResult
$Res call({
 String id, String category, String name, String description,@JsonKey(name: "units_type") String unitsType,@JsonKey(includeToJson: false, fromJson: _colorFromJson) Color color, List<String> units,@JsonKey(name: "learn") List<LearnChapter> learnChapters,@JsonKey(name: "practice") List<PracticeChapter> practiceChapters, String icon
});




}
/// @nodoc
class __$LessonCopyWithImpl<$Res>
    implements _$LessonCopyWith<$Res> {
  __$LessonCopyWithImpl(this._self, this._then);

  final _Lesson _self;
  final $Res Function(_Lesson) _then;

/// Create a copy of Lesson
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? category = null,Object? name = null,Object? description = null,Object? unitsType = null,Object? color = null,Object? units = null,Object? learnChapters = null,Object? practiceChapters = null,Object? icon = null,}) {
  return _then(_Lesson(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,unitsType: null == unitsType ? _self.unitsType : unitsType // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,units: null == units ? _self._units : units // ignore: cast_nullable_to_non_nullable
as List<String>,learnChapters: null == learnChapters ? _self._learnChapters : learnChapters // ignore: cast_nullable_to_non_nullable
as List<LearnChapter>,practiceChapters: null == practiceChapters ? _self._practiceChapters : practiceChapters // ignore: cast_nullable_to_non_nullable
as List<PracticeChapter>,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
