// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomePageState {

 List<Lesson> get ongoingLessons; List<Lesson> get newLessons; List<Lesson> get finishedLessons; Duration get averageTimePerLesson; Duration get averageTimePerQuestion; int get lessonsCompleted;
/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomePageStateCopyWith<HomePageState> get copyWith => _$HomePageStateCopyWithImpl<HomePageState>(this as HomePageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomePageState&&const DeepCollectionEquality().equals(other.ongoingLessons, ongoingLessons)&&const DeepCollectionEquality().equals(other.newLessons, newLessons)&&const DeepCollectionEquality().equals(other.finishedLessons, finishedLessons)&&(identical(other.averageTimePerLesson, averageTimePerLesson) || other.averageTimePerLesson == averageTimePerLesson)&&(identical(other.averageTimePerQuestion, averageTimePerQuestion) || other.averageTimePerQuestion == averageTimePerQuestion)&&(identical(other.lessonsCompleted, lessonsCompleted) || other.lessonsCompleted == lessonsCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(ongoingLessons),const DeepCollectionEquality().hash(newLessons),const DeepCollectionEquality().hash(finishedLessons),averageTimePerLesson,averageTimePerQuestion,lessonsCompleted);

@override
String toString() {
  return 'HomePageState(ongoingLessons: $ongoingLessons, newLessons: $newLessons, finishedLessons: $finishedLessons, averageTimePerLesson: $averageTimePerLesson, averageTimePerQuestion: $averageTimePerQuestion, lessonsCompleted: $lessonsCompleted)';
}


}

/// @nodoc
abstract mixin class $HomePageStateCopyWith<$Res>  {
  factory $HomePageStateCopyWith(HomePageState value, $Res Function(HomePageState) _then) = _$HomePageStateCopyWithImpl;
@useResult
$Res call({
 List<Lesson> ongoingLessons, List<Lesson> newLessons, List<Lesson> finishedLessons, Duration averageTimePerLesson, Duration averageTimePerQuestion, int lessonsCompleted
});




}
/// @nodoc
class _$HomePageStateCopyWithImpl<$Res>
    implements $HomePageStateCopyWith<$Res> {
  _$HomePageStateCopyWithImpl(this._self, this._then);

  final HomePageState _self;
  final $Res Function(HomePageState) _then;

/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ongoingLessons = null,Object? newLessons = null,Object? finishedLessons = null,Object? averageTimePerLesson = null,Object? averageTimePerQuestion = null,Object? lessonsCompleted = null,}) {
  return _then(_self.copyWith(
ongoingLessons: null == ongoingLessons ? _self.ongoingLessons : ongoingLessons // ignore: cast_nullable_to_non_nullable
as List<Lesson>,newLessons: null == newLessons ? _self.newLessons : newLessons // ignore: cast_nullable_to_non_nullable
as List<Lesson>,finishedLessons: null == finishedLessons ? _self.finishedLessons : finishedLessons // ignore: cast_nullable_to_non_nullable
as List<Lesson>,averageTimePerLesson: null == averageTimePerLesson ? _self.averageTimePerLesson : averageTimePerLesson // ignore: cast_nullable_to_non_nullable
as Duration,averageTimePerQuestion: null == averageTimePerQuestion ? _self.averageTimePerQuestion : averageTimePerQuestion // ignore: cast_nullable_to_non_nullable
as Duration,lessonsCompleted: null == lessonsCompleted ? _self.lessonsCompleted : lessonsCompleted // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class _HomePageState extends HomePageState {
  const _HomePageState({required final  List<Lesson> ongoingLessons, required final  List<Lesson> newLessons, required final  List<Lesson> finishedLessons, required this.averageTimePerLesson, required this.averageTimePerQuestion, required this.lessonsCompleted}): _ongoingLessons = ongoingLessons,_newLessons = newLessons,_finishedLessons = finishedLessons,super._();
  

 final  List<Lesson> _ongoingLessons;
@override List<Lesson> get ongoingLessons {
  if (_ongoingLessons is EqualUnmodifiableListView) return _ongoingLessons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ongoingLessons);
}

 final  List<Lesson> _newLessons;
@override List<Lesson> get newLessons {
  if (_newLessons is EqualUnmodifiableListView) return _newLessons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_newLessons);
}

 final  List<Lesson> _finishedLessons;
@override List<Lesson> get finishedLessons {
  if (_finishedLessons is EqualUnmodifiableListView) return _finishedLessons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_finishedLessons);
}

@override final  Duration averageTimePerLesson;
@override final  Duration averageTimePerQuestion;
@override final  int lessonsCompleted;

/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomePageStateCopyWith<_HomePageState> get copyWith => __$HomePageStateCopyWithImpl<_HomePageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomePageState&&const DeepCollectionEquality().equals(other._ongoingLessons, _ongoingLessons)&&const DeepCollectionEquality().equals(other._newLessons, _newLessons)&&const DeepCollectionEquality().equals(other._finishedLessons, _finishedLessons)&&(identical(other.averageTimePerLesson, averageTimePerLesson) || other.averageTimePerLesson == averageTimePerLesson)&&(identical(other.averageTimePerQuestion, averageTimePerQuestion) || other.averageTimePerQuestion == averageTimePerQuestion)&&(identical(other.lessonsCompleted, lessonsCompleted) || other.lessonsCompleted == lessonsCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_ongoingLessons),const DeepCollectionEquality().hash(_newLessons),const DeepCollectionEquality().hash(_finishedLessons),averageTimePerLesson,averageTimePerQuestion,lessonsCompleted);

@override
String toString() {
  return 'HomePageState(ongoingLessons: $ongoingLessons, newLessons: $newLessons, finishedLessons: $finishedLessons, averageTimePerLesson: $averageTimePerLesson, averageTimePerQuestion: $averageTimePerQuestion, lessonsCompleted: $lessonsCompleted)';
}


}

/// @nodoc
abstract mixin class _$HomePageStateCopyWith<$Res> implements $HomePageStateCopyWith<$Res> {
  factory _$HomePageStateCopyWith(_HomePageState value, $Res Function(_HomePageState) _then) = __$HomePageStateCopyWithImpl;
@override @useResult
$Res call({
 List<Lesson> ongoingLessons, List<Lesson> newLessons, List<Lesson> finishedLessons, Duration averageTimePerLesson, Duration averageTimePerQuestion, int lessonsCompleted
});




}
/// @nodoc
class __$HomePageStateCopyWithImpl<$Res>
    implements _$HomePageStateCopyWith<$Res> {
  __$HomePageStateCopyWithImpl(this._self, this._then);

  final _HomePageState _self;
  final $Res Function(_HomePageState) _then;

/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ongoingLessons = null,Object? newLessons = null,Object? finishedLessons = null,Object? averageTimePerLesson = null,Object? averageTimePerQuestion = null,Object? lessonsCompleted = null,}) {
  return _then(_HomePageState(
ongoingLessons: null == ongoingLessons ? _self._ongoingLessons : ongoingLessons // ignore: cast_nullable_to_non_nullable
as List<Lesson>,newLessons: null == newLessons ? _self._newLessons : newLessons // ignore: cast_nullable_to_non_nullable
as List<Lesson>,finishedLessons: null == finishedLessons ? _self._finishedLessons : finishedLessons // ignore: cast_nullable_to_non_nullable
as List<Lesson>,averageTimePerLesson: null == averageTimePerLesson ? _self.averageTimePerLesson : averageTimePerLesson // ignore: cast_nullable_to_non_nullable
as Duration,averageTimePerQuestion: null == averageTimePerQuestion ? _self.averageTimePerQuestion : averageTimePerQuestion // ignore: cast_nullable_to_non_nullable
as Duration,lessonsCompleted: null == lessonsCompleted ? _self.lessonsCompleted : lessonsCompleted // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
