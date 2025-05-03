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

 Lesson? get lastLessonReviewed; List<Lesson> get ongoingLessons; List<Lesson> get newLessons; List<Lesson> get finishedLessons; Duration get averageTimePerChapter; int get chaptersFinished; int get correctRate;
/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomePageStateCopyWith<HomePageState> get copyWith => _$HomePageStateCopyWithImpl<HomePageState>(this as HomePageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomePageState&&(identical(other.lastLessonReviewed, lastLessonReviewed) || other.lastLessonReviewed == lastLessonReviewed)&&const DeepCollectionEquality().equals(other.ongoingLessons, ongoingLessons)&&const DeepCollectionEquality().equals(other.newLessons, newLessons)&&const DeepCollectionEquality().equals(other.finishedLessons, finishedLessons)&&(identical(other.averageTimePerChapter, averageTimePerChapter) || other.averageTimePerChapter == averageTimePerChapter)&&(identical(other.chaptersFinished, chaptersFinished) || other.chaptersFinished == chaptersFinished)&&(identical(other.correctRate, correctRate) || other.correctRate == correctRate));
}


@override
int get hashCode => Object.hash(runtimeType,lastLessonReviewed,const DeepCollectionEquality().hash(ongoingLessons),const DeepCollectionEquality().hash(newLessons),const DeepCollectionEquality().hash(finishedLessons),averageTimePerChapter,chaptersFinished,correctRate);

@override
String toString() {
  return 'HomePageState(lastLessonReviewed: $lastLessonReviewed, ongoingLessons: $ongoingLessons, newLessons: $newLessons, finishedLessons: $finishedLessons, averageTimePerChapter: $averageTimePerChapter, chaptersFinished: $chaptersFinished, correctRate: $correctRate)';
}


}

/// @nodoc
abstract mixin class $HomePageStateCopyWith<$Res>  {
  factory $HomePageStateCopyWith(HomePageState value, $Res Function(HomePageState) _then) = _$HomePageStateCopyWithImpl;
@useResult
$Res call({
 Lesson? lastLessonReviewed, List<Lesson> ongoingLessons, List<Lesson> newLessons, List<Lesson> finishedLessons, Duration averageTimePerChapter, int chaptersFinished, int correctRate
});


$LessonCopyWith<$Res>? get lastLessonReviewed;

}
/// @nodoc
class _$HomePageStateCopyWithImpl<$Res>
    implements $HomePageStateCopyWith<$Res> {
  _$HomePageStateCopyWithImpl(this._self, this._then);

  final HomePageState _self;
  final $Res Function(HomePageState) _then;

/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lastLessonReviewed = freezed,Object? ongoingLessons = null,Object? newLessons = null,Object? finishedLessons = null,Object? averageTimePerChapter = null,Object? chaptersFinished = null,Object? correctRate = null,}) {
  return _then(_self.copyWith(
lastLessonReviewed: freezed == lastLessonReviewed ? _self.lastLessonReviewed : lastLessonReviewed // ignore: cast_nullable_to_non_nullable
as Lesson?,ongoingLessons: null == ongoingLessons ? _self.ongoingLessons : ongoingLessons // ignore: cast_nullable_to_non_nullable
as List<Lesson>,newLessons: null == newLessons ? _self.newLessons : newLessons // ignore: cast_nullable_to_non_nullable
as List<Lesson>,finishedLessons: null == finishedLessons ? _self.finishedLessons : finishedLessons // ignore: cast_nullable_to_non_nullable
as List<Lesson>,averageTimePerChapter: null == averageTimePerChapter ? _self.averageTimePerChapter : averageTimePerChapter // ignore: cast_nullable_to_non_nullable
as Duration,chaptersFinished: null == chaptersFinished ? _self.chaptersFinished : chaptersFinished // ignore: cast_nullable_to_non_nullable
as int,correctRate: null == correctRate ? _self.correctRate : correctRate // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LessonCopyWith<$Res>? get lastLessonReviewed {
    if (_self.lastLessonReviewed == null) {
    return null;
  }

  return $LessonCopyWith<$Res>(_self.lastLessonReviewed!, (value) {
    return _then(_self.copyWith(lastLessonReviewed: value));
  });
}
}


/// @nodoc


class _HomePageState extends HomePageState {
  const _HomePageState({required this.lastLessonReviewed, required final  List<Lesson> ongoingLessons, required final  List<Lesson> newLessons, required final  List<Lesson> finishedLessons, required this.averageTimePerChapter, required this.chaptersFinished, required this.correctRate}): _ongoingLessons = ongoingLessons,_newLessons = newLessons,_finishedLessons = finishedLessons,super._();
  

@override final  Lesson? lastLessonReviewed;
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

@override final  Duration averageTimePerChapter;
@override final  int chaptersFinished;
@override final  int correctRate;

/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomePageStateCopyWith<_HomePageState> get copyWith => __$HomePageStateCopyWithImpl<_HomePageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomePageState&&(identical(other.lastLessonReviewed, lastLessonReviewed) || other.lastLessonReviewed == lastLessonReviewed)&&const DeepCollectionEquality().equals(other._ongoingLessons, _ongoingLessons)&&const DeepCollectionEquality().equals(other._newLessons, _newLessons)&&const DeepCollectionEquality().equals(other._finishedLessons, _finishedLessons)&&(identical(other.averageTimePerChapter, averageTimePerChapter) || other.averageTimePerChapter == averageTimePerChapter)&&(identical(other.chaptersFinished, chaptersFinished) || other.chaptersFinished == chaptersFinished)&&(identical(other.correctRate, correctRate) || other.correctRate == correctRate));
}


@override
int get hashCode => Object.hash(runtimeType,lastLessonReviewed,const DeepCollectionEquality().hash(_ongoingLessons),const DeepCollectionEquality().hash(_newLessons),const DeepCollectionEquality().hash(_finishedLessons),averageTimePerChapter,chaptersFinished,correctRate);

@override
String toString() {
  return 'HomePageState(lastLessonReviewed: $lastLessonReviewed, ongoingLessons: $ongoingLessons, newLessons: $newLessons, finishedLessons: $finishedLessons, averageTimePerChapter: $averageTimePerChapter, chaptersFinished: $chaptersFinished, correctRate: $correctRate)';
}


}

/// @nodoc
abstract mixin class _$HomePageStateCopyWith<$Res> implements $HomePageStateCopyWith<$Res> {
  factory _$HomePageStateCopyWith(_HomePageState value, $Res Function(_HomePageState) _then) = __$HomePageStateCopyWithImpl;
@override @useResult
$Res call({
 Lesson? lastLessonReviewed, List<Lesson> ongoingLessons, List<Lesson> newLessons, List<Lesson> finishedLessons, Duration averageTimePerChapter, int chaptersFinished, int correctRate
});


@override $LessonCopyWith<$Res>? get lastLessonReviewed;

}
/// @nodoc
class __$HomePageStateCopyWithImpl<$Res>
    implements _$HomePageStateCopyWith<$Res> {
  __$HomePageStateCopyWithImpl(this._self, this._then);

  final _HomePageState _self;
  final $Res Function(_HomePageState) _then;

/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastLessonReviewed = freezed,Object? ongoingLessons = null,Object? newLessons = null,Object? finishedLessons = null,Object? averageTimePerChapter = null,Object? chaptersFinished = null,Object? correctRate = null,}) {
  return _then(_HomePageState(
lastLessonReviewed: freezed == lastLessonReviewed ? _self.lastLessonReviewed : lastLessonReviewed // ignore: cast_nullable_to_non_nullable
as Lesson?,ongoingLessons: null == ongoingLessons ? _self._ongoingLessons : ongoingLessons // ignore: cast_nullable_to_non_nullable
as List<Lesson>,newLessons: null == newLessons ? _self._newLessons : newLessons // ignore: cast_nullable_to_non_nullable
as List<Lesson>,finishedLessons: null == finishedLessons ? _self._finishedLessons : finishedLessons // ignore: cast_nullable_to_non_nullable
as List<Lesson>,averageTimePerChapter: null == averageTimePerChapter ? _self.averageTimePerChapter : averageTimePerChapter // ignore: cast_nullable_to_non_nullable
as Duration,chaptersFinished: null == chaptersFinished ? _self.chaptersFinished : chaptersFinished // ignore: cast_nullable_to_non_nullable
as int,correctRate: null == correctRate ? _self.correctRate : correctRate // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of HomePageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LessonCopyWith<$Res>? get lastLessonReviewed {
    if (_self.lastLessonReviewed == null) {
    return null;
  }

  return $LessonCopyWith<$Res>(_self.lastLessonReviewed!, (value) {
    return _then(_self.copyWith(lastLessonReviewed: value));
  });
}
}

// dart format on
