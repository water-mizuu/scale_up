// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learn_chapter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LearnChapter {

 String get type; String get name; List<String> get units;
/// Create a copy of LearnChapter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearnChapterCopyWith<LearnChapter> get copyWith => _$LearnChapterCopyWithImpl<LearnChapter>(this as LearnChapter, _$identity);

  /// Serializes this LearnChapter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearnChapter&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.units, units));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,name,const DeepCollectionEquality().hash(units));

@override
String toString() {
  return 'LearnChapter(type: $type, name: $name, units: $units)';
}


}

/// @nodoc
abstract mixin class $LearnChapterCopyWith<$Res>  {
  factory $LearnChapterCopyWith(LearnChapter value, $Res Function(LearnChapter) _then) = _$LearnChapterCopyWithImpl;
@useResult
$Res call({
 String type, String name, List<String> units
});




}
/// @nodoc
class _$LearnChapterCopyWithImpl<$Res>
    implements $LearnChapterCopyWith<$Res> {
  _$LearnChapterCopyWithImpl(this._self, this._then);

  final LearnChapter _self;
  final $Res Function(LearnChapter) _then;

/// Create a copy of LearnChapter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? name = null,Object? units = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,units: null == units ? _self.units : units // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _LearnChapter extends LearnChapter {
  const _LearnChapter({required this.type, required this.name, required final  List<String> units}): _units = units,super._();
  factory _LearnChapter.fromJson(Map<String, dynamic> json) => _$LearnChapterFromJson(json);

@override final  String type;
@override final  String name;
 final  List<String> _units;
@override List<String> get units {
  if (_units is EqualUnmodifiableListView) return _units;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_units);
}


/// Create a copy of LearnChapter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LearnChapterCopyWith<_LearnChapter> get copyWith => __$LearnChapterCopyWithImpl<_LearnChapter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LearnChapterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LearnChapter&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._units, _units));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,name,const DeepCollectionEquality().hash(_units));

@override
String toString() {
  return 'LearnChapter(type: $type, name: $name, units: $units)';
}


}

/// @nodoc
abstract mixin class _$LearnChapterCopyWith<$Res> implements $LearnChapterCopyWith<$Res> {
  factory _$LearnChapterCopyWith(_LearnChapter value, $Res Function(_LearnChapter) _then) = __$LearnChapterCopyWithImpl;
@override @useResult
$Res call({
 String type, String name, List<String> units
});




}
/// @nodoc
class __$LearnChapterCopyWithImpl<$Res>
    implements _$LearnChapterCopyWith<$Res> {
  __$LearnChapterCopyWithImpl(this._self, this._then);

  final _LearnChapter _self;
  final $Res Function(_LearnChapter) _then;

/// Create a copy of LearnChapter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? name = null,Object? units = null,}) {
  return _then(_LearnChapter(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,units: null == units ? _self._units : units // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
