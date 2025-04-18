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

 ChapterPageStatus get status; Lesson get lesson; int get chapterIndex; String? get answer; String? get correctAnswer; String? get error;
/// Create a copy of PracticePageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticePageStateCopyWith<PracticePageState> get copyWith => _$PracticePageStateCopyWithImpl<PracticePageState>(this as PracticePageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticePageState&&(identical(other.status, status) || other.status == status)&&(identical(other.lesson, lesson) || other.lesson == lesson)&&(identical(other.chapterIndex, chapterIndex) || other.chapterIndex == chapterIndex)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.correctAnswer, correctAnswer) || other.correctAnswer == correctAnswer)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,lesson,chapterIndex,answer,correctAnswer,error);

@override
String toString() {
  return 'PracticePageState(status: $status, lesson: $lesson, chapterIndex: $chapterIndex, answer: $answer, correctAnswer: $correctAnswer, error: $error)';
}


}

/// @nodoc
abstract mixin class $PracticePageStateCopyWith<$Res>  {
  factory $PracticePageStateCopyWith(PracticePageState value, $Res Function(PracticePageState) _then) = _$PracticePageStateCopyWithImpl;
@useResult
$Res call({
 ChapterPageStatus status, Lesson lesson, int chapterIndex, String? answer, String? correctAnswer, String? error
});


$LessonCopyWith<$Res> get lesson;

}
/// @nodoc
class _$PracticePageStateCopyWithImpl<$Res>
    implements $PracticePageStateCopyWith<$Res> {
  _$PracticePageStateCopyWithImpl(this._self, this._then);

  final PracticePageState _self;
  final $Res Function(PracticePageState) _then;

/// Create a copy of PracticePageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? lesson = null,Object? chapterIndex = null,Object? answer = freezed,Object? correctAnswer = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChapterPageStatus,lesson: null == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as Lesson,chapterIndex: null == chapterIndex ? _self.chapterIndex : chapterIndex // ignore: cast_nullable_to_non_nullable
as int,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String?,correctAnswer: freezed == correctAnswer ? _self.correctAnswer : correctAnswer // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
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


/// @nodoc


class InitialChapterPageState extends PracticePageState {
  const InitialChapterPageState({required this.status, required this.lesson, required this.chapterIndex, this.answer, this.correctAnswer, this.error}): super._();
  

@override final  ChapterPageStatus status;
@override final  Lesson lesson;
@override final  int chapterIndex;
@override final  String? answer;
@override final  String? correctAnswer;
@override final  String? error;

/// Create a copy of PracticePageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitialChapterPageStateCopyWith<InitialChapterPageState> get copyWith => _$InitialChapterPageStateCopyWithImpl<InitialChapterPageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialChapterPageState&&(identical(other.status, status) || other.status == status)&&(identical(other.lesson, lesson) || other.lesson == lesson)&&(identical(other.chapterIndex, chapterIndex) || other.chapterIndex == chapterIndex)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.correctAnswer, correctAnswer) || other.correctAnswer == correctAnswer)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,lesson,chapterIndex,answer,correctAnswer,error);

@override
String toString() {
  return 'PracticePageState.initial(status: $status, lesson: $lesson, chapterIndex: $chapterIndex, answer: $answer, correctAnswer: $correctAnswer, error: $error)';
}


}

/// @nodoc
abstract mixin class $InitialChapterPageStateCopyWith<$Res> implements $PracticePageStateCopyWith<$Res> {
  factory $InitialChapterPageStateCopyWith(InitialChapterPageState value, $Res Function(InitialChapterPageState) _then) = _$InitialChapterPageStateCopyWithImpl;
@override @useResult
$Res call({
 ChapterPageStatus status, Lesson lesson, int chapterIndex, String? answer, String? correctAnswer, String? error
});


@override $LessonCopyWith<$Res> get lesson;

}
/// @nodoc
class _$InitialChapterPageStateCopyWithImpl<$Res>
    implements $InitialChapterPageStateCopyWith<$Res> {
  _$InitialChapterPageStateCopyWithImpl(this._self, this._then);

  final InitialChapterPageState _self;
  final $Res Function(InitialChapterPageState) _then;

/// Create a copy of PracticePageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? lesson = null,Object? chapterIndex = null,Object? answer = freezed,Object? correctAnswer = freezed,Object? error = freezed,}) {
  return _then(InitialChapterPageState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChapterPageStatus,lesson: null == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as Lesson,chapterIndex: null == chapterIndex ? _self.chapterIndex : chapterIndex // ignore: cast_nullable_to_non_nullable
as int,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String?,correctAnswer: freezed == correctAnswer ? _self.correctAnswer : correctAnswer // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
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

/// @nodoc


class LoadedChapterPageState extends PracticePageState {
  const LoadedChapterPageState({required this.status, required this.chapterIndex, required this.lesson, required final  List<(Unit, Unit, num, List<((Unit, Unit), Expression)>)> questions, required this.questionIndex, this.answer, this.correctAnswer, this.error}): _questions = questions,super._();
  

@override final  ChapterPageStatus status;
@override final  int chapterIndex;
@override final  Lesson lesson;
 final  List<(Unit, Unit, num, List<((Unit, Unit), Expression)>)> _questions;
 List<(Unit, Unit, num, List<((Unit, Unit), Expression)>)> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

 final  int questionIndex;
@override final  String? answer;
@override final  String? correctAnswer;
@override final  String? error;

/// Create a copy of PracticePageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedChapterPageStateCopyWith<LoadedChapterPageState> get copyWith => _$LoadedChapterPageStateCopyWithImpl<LoadedChapterPageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedChapterPageState&&(identical(other.status, status) || other.status == status)&&(identical(other.chapterIndex, chapterIndex) || other.chapterIndex == chapterIndex)&&(identical(other.lesson, lesson) || other.lesson == lesson)&&const DeepCollectionEquality().equals(other._questions, _questions)&&(identical(other.questionIndex, questionIndex) || other.questionIndex == questionIndex)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.correctAnswer, correctAnswer) || other.correctAnswer == correctAnswer)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,chapterIndex,lesson,const DeepCollectionEquality().hash(_questions),questionIndex,answer,correctAnswer,error);

@override
String toString() {
  return 'PracticePageState.loaded(status: $status, chapterIndex: $chapterIndex, lesson: $lesson, questions: $questions, questionIndex: $questionIndex, answer: $answer, correctAnswer: $correctAnswer, error: $error)';
}


}

/// @nodoc
abstract mixin class $LoadedChapterPageStateCopyWith<$Res> implements $PracticePageStateCopyWith<$Res> {
  factory $LoadedChapterPageStateCopyWith(LoadedChapterPageState value, $Res Function(LoadedChapterPageState) _then) = _$LoadedChapterPageStateCopyWithImpl;
@override @useResult
$Res call({
 ChapterPageStatus status, int chapterIndex, Lesson lesson, List<(Unit, Unit, num, List<((Unit, Unit), Expression)>)> questions, int questionIndex, String? answer, String? correctAnswer, String? error
});


@override $LessonCopyWith<$Res> get lesson;

}
/// @nodoc
class _$LoadedChapterPageStateCopyWithImpl<$Res>
    implements $LoadedChapterPageStateCopyWith<$Res> {
  _$LoadedChapterPageStateCopyWithImpl(this._self, this._then);

  final LoadedChapterPageState _self;
  final $Res Function(LoadedChapterPageState) _then;

/// Create a copy of PracticePageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? chapterIndex = null,Object? lesson = null,Object? questions = null,Object? questionIndex = null,Object? answer = freezed,Object? correctAnswer = freezed,Object? error = freezed,}) {
  return _then(LoadedChapterPageState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChapterPageStatus,chapterIndex: null == chapterIndex ? _self.chapterIndex : chapterIndex // ignore: cast_nullable_to_non_nullable
as int,lesson: null == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as Lesson,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<(Unit, Unit, num, List<((Unit, Unit), Expression)>)>,questionIndex: null == questionIndex ? _self.questionIndex : questionIndex // ignore: cast_nullable_to_non_nullable
as int,answer: freezed == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String?,correctAnswer: freezed == correctAnswer ? _self.correctAnswer : correctAnswer // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
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
