// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'practice_chapter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PracticeChapter {

 String get name;@JsonKey(name: "question_count") int get questionCount; List<String> get units;
/// Create a copy of PracticeChapter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticeChapterCopyWith<PracticeChapter> get copyWith => _$PracticeChapterCopyWithImpl<PracticeChapter>(this as PracticeChapter, _$identity);

  /// Serializes this PracticeChapter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticeChapter&&(identical(other.name, name) || other.name == name)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&const DeepCollectionEquality().equals(other.units, units));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,questionCount,const DeepCollectionEquality().hash(units));

@override
String toString() {
  return 'PracticeChapter(name: $name, questionCount: $questionCount, units: $units)';
}


}

/// @nodoc
abstract mixin class $PracticeChapterCopyWith<$Res>  {
  factory $PracticeChapterCopyWith(PracticeChapter value, $Res Function(PracticeChapter) _then) = _$PracticeChapterCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: "question_count") int questionCount, List<String> units
});




}
/// @nodoc
class _$PracticeChapterCopyWithImpl<$Res>
    implements $PracticeChapterCopyWith<$Res> {
  _$PracticeChapterCopyWithImpl(this._self, this._then);

  final PracticeChapter _self;
  final $Res Function(PracticeChapter) _then;

/// Create a copy of PracticeChapter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? questionCount = null,Object? units = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,units: null == units ? _self.units : units // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PracticeChapter implements PracticeChapter {
  const _PracticeChapter({required this.name, @JsonKey(name: "question_count") required this.questionCount, required final  List<String> units}): _units = units;
  factory _PracticeChapter.fromJson(Map<String, dynamic> json) => _$PracticeChapterFromJson(json);

@override final  String name;
@override@JsonKey(name: "question_count") final  int questionCount;
 final  List<String> _units;
@override List<String> get units {
  if (_units is EqualUnmodifiableListView) return _units;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_units);
}


/// Create a copy of PracticeChapter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticeChapterCopyWith<_PracticeChapter> get copyWith => __$PracticeChapterCopyWithImpl<_PracticeChapter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PracticeChapterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticeChapter&&(identical(other.name, name) || other.name == name)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&const DeepCollectionEquality().equals(other._units, _units));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,questionCount,const DeepCollectionEquality().hash(_units));

@override
String toString() {
  return 'PracticeChapter(name: $name, questionCount: $questionCount, units: $units)';
}


}

/// @nodoc
abstract mixin class _$PracticeChapterCopyWith<$Res> implements $PracticeChapterCopyWith<$Res> {
  factory _$PracticeChapterCopyWith(_PracticeChapter value, $Res Function(_PracticeChapter) _then) = __$PracticeChapterCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: "question_count") int questionCount, List<String> units
});




}
/// @nodoc
class __$PracticeChapterCopyWithImpl<$Res>
    implements _$PracticeChapterCopyWith<$Res> {
  __$PracticeChapterCopyWithImpl(this._self, this._then);

  final _PracticeChapter _self;
  final $Res Function(_PracticeChapter) _then;

/// Create a copy of PracticeChapter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? questionCount = null,Object? units = null,}) {
  return _then(_PracticeChapter(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,units: null == units ? _self._units : units // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
