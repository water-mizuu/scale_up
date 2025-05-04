// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'practice_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PracticePageState {

 PracticePageStatus get status; Lesson? get lesson; int get chapterIndex; Object? get error;
/// Create a copy of PracticePageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticePageStateCopyWith<PracticePageState> get copyWith => _$PracticePageStateCopyWithImpl<PracticePageState>(this as PracticePageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticePageState&&(identical(other.status, status) || other.status == status)&&(identical(other.lesson, lesson) || other.lesson == lesson)&&(identical(other.chapterIndex, chapterIndex) || other.chapterIndex == chapterIndex)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,status,lesson,chapterIndex,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'PracticePageState(status: $status, lesson: $lesson, chapterIndex: $chapterIndex, error: $error)';
}


}

/// @nodoc
abstract mixin class $PracticePageStateCopyWith<$Res>  {
  factory $PracticePageStateCopyWith(PracticePageState value, $Res Function(PracticePageState) _then) = _$PracticePageStateCopyWithImpl;
@useResult
$Res call({
 PracticePageStatus status, Lesson lesson, int chapterIndex, Object? error
});


$LessonCopyWith<$Res>? get lesson;

}
/// @nodoc
class _$PracticePageStateCopyWithImpl<$Res>
    implements $PracticePageStateCopyWith<$Res> {
  _$PracticePageStateCopyWithImpl(this._self, this._then);

  final PracticePageState _self;
  final $Res Function(PracticePageState) _then;

/// Create a copy of PracticePageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? lesson = null,Object? chapterIndex = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PracticePageStatus,lesson: null == lesson ? _self.lesson! : lesson // ignore: cast_nullable_to_non_nullable
as Lesson,chapterIndex: null == chapterIndex ? _self.chapterIndex : chapterIndex // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error ,
  ));
}
/// Create a copy of PracticePageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LessonCopyWith<$Res>? get lesson {
    if (_self.lesson == null) {
    return null;
  }

  return $LessonCopyWith<$Res>(_self.lesson!, (value) {
    return _then(_self.copyWith(lesson: value));
  });
}
}


/// @nodoc


class InitialPracticePageState extends PracticePageState {
  const InitialPracticePageState({required this.status, required this.lesson, required this.chapterIndex, this.error}): super._();
  

@override final  PracticePageStatus status;
@override final  Lesson? lesson;
@override final  int chapterIndex;
@override final  Object? error;

/// Create a copy of PracticePageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitialPracticePageStateCopyWith<InitialPracticePageState> get copyWith => _$InitialPracticePageStateCopyWithImpl<InitialPracticePageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialPracticePageState&&(identical(other.status, status) || other.status == status)&&(identical(other.lesson, lesson) || other.lesson == lesson)&&(identical(other.chapterIndex, chapterIndex) || other.chapterIndex == chapterIndex)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,status,lesson,chapterIndex,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'PracticePageState.loading(status: $status, lesson: $lesson, chapterIndex: $chapterIndex, error: $error)';
}


}

/// @nodoc
abstract mixin class $InitialPracticePageStateCopyWith<$Res> implements $PracticePageStateCopyWith<$Res> {
  factory $InitialPracticePageStateCopyWith(InitialPracticePageState value, $Res Function(InitialPracticePageState) _then) = _$InitialPracticePageStateCopyWithImpl;
@override @useResult
$Res call({
 PracticePageStatus status, Lesson? lesson, int chapterIndex, Object? error
});


@override $LessonCopyWith<$Res>? get lesson;

}
/// @nodoc
class _$InitialPracticePageStateCopyWithImpl<$Res>
    implements $InitialPracticePageStateCopyWith<$Res> {
  _$InitialPracticePageStateCopyWithImpl(this._self, this._then);

  final InitialPracticePageState _self;
  final $Res Function(InitialPracticePageState) _then;

/// Create a copy of PracticePageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? lesson = freezed,Object? chapterIndex = null,Object? error = freezed,}) {
  return _then(InitialPracticePageState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PracticePageStatus,lesson: freezed == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as Lesson?,chapterIndex: null == chapterIndex ? _self.chapterIndex : chapterIndex // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error ,
  ));
}

/// Create a copy of PracticePageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LessonCopyWith<$Res>? get lesson {
    if (_self.lesson == null) {
    return null;
  }

  return $LessonCopyWith<$Res>(_self.lesson!, (value) {
    return _then(_self.copyWith(lesson: value));
  });
}
}

/// @nodoc


class LoadedPracticePageState extends PracticePageState {
  const LoadedPracticePageState({required this.status, required this.chapterIndex, required this.lesson, required final  List<(Unit, Unit, num, List<((Unit, Unit), NumericalExpression)>, {bool isRetry})> questions, required this.questionIndex, required this.progress, required this.mistakes, required this.startDateTime, this.answer, this.correctAnswer, this.error}): _questions = questions,super._();
  

@override final  PracticePageStatus status;
@override final  int chapterIndex;
@override final  Lesson lesson;
 final  List<(Unit, Unit, num, List<((Unit, Unit), NumericalExpression)>, {bool isRetry})> _questions;
 List<(Unit, Unit, num, List<((Unit, Unit), NumericalExpression)>, {bool isRetry})> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

 final  int questionIndex;
 final  double progress;
 final  int mistakes;
 final  DateTime startDateTime;
 final  double? answer;
 final  String? correctAnswer;
@override final  Object? error;

/// Create a copy of PracticePageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedPracticePageStateCopyWith<LoadedPracticePageState> get copyWith => _$LoadedPracticePageStateCopyWithImpl<LoadedPracticePageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedPracticePageState&&(identical(other.status, status) || other.status == status)&&(identical(other.chapterIndex, chapterIndex) || other.chapterIndex == chapterIndex)&&(identical(other.lesson, lesson) || other.lesson == lesson)&&const DeepCollectionEquality().equals(other._questions, _questions)&&(identical(other.questionIndex, questionIndex) || other.questionIndex == questionIndex)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.mistakes, mistakes) || other.mistakes == mistakes)&&(identical(other.startDateTime, startDateTime) || other.startDateTime == startDateTime)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.correctAnswer, correctAnswer) || other.correctAnswer == correctAnswer)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,status,chapterIndex,lesson,const DeepCollectionEquality().hash(_questions),questionIndex,progress,mistakes,startDateTime,answer,correctAnswer,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'PracticePageState.loaded(status: $status, chapterIndex: $chapterIndex, lesson: $lesson, questions: $questions, questionIndex: $questionIndex, progress: $progress, mistakes: $mistakes, startDateTime: $startDateTime, answer: $answer, correctAnswer: $correctAnswer, error: $error)';
}


}

/// @nodoc
abstract mixin class $LoadedPracticePageStateCopyWith<$Res> implements $PracticePageStateCopyWith<$Res> {
  factory $LoadedPracticePageStateCopyWith(LoadedPracticePageState value, $Res Function(LoadedPracticePageState) _then) = _$LoadedPracticePageStateCopyWithImpl;
@override @useResult
$Res call({
 PracticePageStatus status, int chapterIndex, Lesson lesson, List<(Unit, Unit, num, List<((Unit, Unit), NumericalExpression)>, {bool isRetry})> questions, int questionIndex, double progress, int mistakes, DateTime startDateTime, double? answer, String? correctAnswer, Object? error
});


@override $LessonCopyWith<$Res> get lesson;

}
/// @nodoc
class _$LoadedPracticePageStateCopyWithImpl<$Res>
    implements $LoadedPracticePageStateCopyWith<$Res> {
  _$LoadedPracticePageStateCopyWithImpl(this._self, this._then);

  final LoadedPracticePageState _self;
  final $Res Function(LoadedPracticePageState) _then;

/// Create a copy of PracticePageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? chapterIndex = null,Object? lesson = null,Object? questions = null,Object? questionIndex = null,Object? progress = null,Object? mistakes = null,Object? startDateTime = null,Object? answer = freezed,Object? correctAnswer = freezed,Object? error = freezed,}) {
  return _then(LoadedPracticePageState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PracticePageStatus,chapterIndex: null == chapterIndex ? _self.chapterIndex : chapterIndex // ignore: cast_nullable_to_non_nullable
as int,lesson: null == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as Lesson,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<(Unit, Unit, num, List<((Unit, Unit), NumericalExpression)>, {bool isRetry})>,questionIndex: null == questionIndex ? _self.questionIndex : questionIndex // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,mistakes: null == mistakes ? _self.mistakes : mistakes // ignore: cast_nullable_to_non_nullable
as int,startDateTime: null == startDateTime ? _self.startDateTime : startDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as double?,correctAnswer: freezed == correctAnswer ? _self.correctAnswer : correctAnswer // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error ,
  ));
}

/// Create a copy of PracticePageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LessonCopyWith<$Res> get lesson {
  
  return $LessonCopyWith<$Res>(_self.lesson, (value) {
    return _then(_self.copyWith(lesson: value));
  });
}
}

// dart format on
