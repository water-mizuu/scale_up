// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LessonPageState {

 Lesson get lesson; UnitGroup? get localUnitGroup;
/// Create a copy of LessonPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonPageStateCopyWith<LessonPageState> get copyWith => _$LessonPageStateCopyWithImpl<LessonPageState>(this as LessonPageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonPageState&&(identical(other.lesson, lesson) || other.lesson == lesson)&&(identical(other.localUnitGroup, localUnitGroup) || other.localUnitGroup == localUnitGroup));
}


@override
int get hashCode => Object.hash(runtimeType,lesson,localUnitGroup);

@override
String toString() {
  return 'LessonPageState(lesson: $lesson, localUnitGroup: $localUnitGroup)';
}


}

/// @nodoc
abstract mixin class $LessonPageStateCopyWith<$Res>  {
  factory $LessonPageStateCopyWith(LessonPageState value, $Res Function(LessonPageState) _then) = _$LessonPageStateCopyWithImpl;
@useResult
$Res call({
 Lesson lesson, UnitGroup? localUnitGroup
});


$LessonCopyWith<$Res> get lesson;$UnitGroupCopyWith<$Res>? get localUnitGroup;

}
/// @nodoc
class _$LessonPageStateCopyWithImpl<$Res>
    implements $LessonPageStateCopyWith<$Res> {
  _$LessonPageStateCopyWithImpl(this._self, this._then);

  final LessonPageState _self;
  final $Res Function(LessonPageState) _then;

/// Create a copy of LessonPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lesson = null,Object? localUnitGroup = freezed,}) {
  return _then(_self.copyWith(
lesson: null == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as Lesson,localUnitGroup: freezed == localUnitGroup ? _self.localUnitGroup : localUnitGroup // ignore: cast_nullable_to_non_nullable
as UnitGroup?,
  ));
}
/// Create a copy of LessonPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LessonCopyWith<$Res> get lesson {
  
  return $LessonCopyWith<$Res>(_self.lesson, (value) {
    return _then(_self.copyWith(lesson: value));
  });
}/// Create a copy of LessonPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnitGroupCopyWith<$Res>? get localUnitGroup {
    if (_self.localUnitGroup == null) {
    return null;
  }

  return $UnitGroupCopyWith<$Res>(_self.localUnitGroup!, (value) {
    return _then(_self.copyWith(localUnitGroup: value));
  });
}
}


/// @nodoc


class _LessonPageState extends LessonPageState {
  const _LessonPageState({required this.lesson, this.localUnitGroup}): super._();
  

@override final  Lesson lesson;
@override final  UnitGroup? localUnitGroup;

/// Create a copy of LessonPageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonPageStateCopyWith<_LessonPageState> get copyWith => __$LessonPageStateCopyWithImpl<_LessonPageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonPageState&&(identical(other.lesson, lesson) || other.lesson == lesson)&&(identical(other.localUnitGroup, localUnitGroup) || other.localUnitGroup == localUnitGroup));
}


@override
int get hashCode => Object.hash(runtimeType,lesson,localUnitGroup);

@override
String toString() {
  return 'LessonPageState(lesson: $lesson, localUnitGroup: $localUnitGroup)';
}


}

/// @nodoc
abstract mixin class _$LessonPageStateCopyWith<$Res> implements $LessonPageStateCopyWith<$Res> {
  factory _$LessonPageStateCopyWith(_LessonPageState value, $Res Function(_LessonPageState) _then) = __$LessonPageStateCopyWithImpl;
@override @useResult
$Res call({
 Lesson lesson, UnitGroup? localUnitGroup
});


@override $LessonCopyWith<$Res> get lesson;@override $UnitGroupCopyWith<$Res>? get localUnitGroup;

}
/// @nodoc
class __$LessonPageStateCopyWithImpl<$Res>
    implements _$LessonPageStateCopyWith<$Res> {
  __$LessonPageStateCopyWithImpl(this._self, this._then);

  final _LessonPageState _self;
  final $Res Function(_LessonPageState) _then;

/// Create a copy of LessonPageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lesson = null,Object? localUnitGroup = freezed,}) {
  return _then(_LessonPageState(
lesson: null == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as Lesson,localUnitGroup: freezed == localUnitGroup ? _self.localUnitGroup : localUnitGroup // ignore: cast_nullable_to_non_nullable
as UnitGroup?,
  ));
}

/// Create a copy of LessonPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LessonCopyWith<$Res> get lesson {
  
  return $LessonCopyWith<$Res>(_self.lesson, (value) {
    return _then(_self.copyWith(lesson: value));
  });
}/// Create a copy of LessonPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnitGroupCopyWith<$Res>? get localUnitGroup {
    if (_self.localUnitGroup == null) {
    return null;
  }

  return $UnitGroupCopyWith<$Res>(_self.localUnitGroup!, (value) {
    return _then(_self.copyWith(localUnitGroup: value));
  });
}
}

// dart format on
