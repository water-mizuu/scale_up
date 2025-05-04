// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learn_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LearnPageState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearnPageState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LearnPageState()';
}


}

/// @nodoc
class $LearnPageStateCopyWith<$Res>  {
$LearnPageStateCopyWith(LearnPageState _, $Res Function(LearnPageState) __);
}


/// @nodoc


class BlankLearnPageState extends LearnPageState {
  const BlankLearnPageState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlankLearnPageState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LearnPageState.blank()';
}


}




/// @nodoc


class LoadingLearnPageState extends LearnPageState {
  const LoadingLearnPageState({required this.status, required this.lesson, required this.chapterIndex}): super._();
  

 final  LearnPageStatus status;
 final  Lesson? lesson;
 final  int chapterIndex;

/// Create a copy of LearnPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadingLearnPageStateCopyWith<LoadingLearnPageState> get copyWith => _$LoadingLearnPageStateCopyWithImpl<LoadingLearnPageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingLearnPageState&&(identical(other.status, status) || other.status == status)&&(identical(other.lesson, lesson) || other.lesson == lesson)&&(identical(other.chapterIndex, chapterIndex) || other.chapterIndex == chapterIndex));
}


@override
int get hashCode => Object.hash(runtimeType,status,lesson,chapterIndex);

@override
String toString() {
  return 'LearnPageState.loading(status: $status, lesson: $lesson, chapterIndex: $chapterIndex)';
}


}

/// @nodoc
abstract mixin class $LoadingLearnPageStateCopyWith<$Res> implements $LearnPageStateCopyWith<$Res> {
  factory $LoadingLearnPageStateCopyWith(LoadingLearnPageState value, $Res Function(LoadingLearnPageState) _then) = _$LoadingLearnPageStateCopyWithImpl;
@useResult
$Res call({
 LearnPageStatus status, Lesson? lesson, int chapterIndex
});


$LessonCopyWith<$Res>? get lesson;

}
/// @nodoc
class _$LoadingLearnPageStateCopyWithImpl<$Res>
    implements $LoadingLearnPageStateCopyWith<$Res> {
  _$LoadingLearnPageStateCopyWithImpl(this._self, this._then);

  final LoadingLearnPageState _self;
  final $Res Function(LoadingLearnPageState) _then;

/// Create a copy of LearnPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,Object? lesson = freezed,Object? chapterIndex = null,}) {
  return _then(LoadingLearnPageState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LearnPageStatus,lesson: freezed == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as Lesson?,chapterIndex: null == chapterIndex ? _self.chapterIndex : chapterIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of LearnPageState
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


class ErrorLearnPageState extends LearnPageState {
  const ErrorLearnPageState({required this.status, required this.error}): super._();
  

 final  LearnPageStatus status;
 final  String error;

/// Create a copy of LearnPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorLearnPageStateCopyWith<ErrorLearnPageState> get copyWith => _$ErrorLearnPageStateCopyWithImpl<ErrorLearnPageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorLearnPageState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,error);

@override
String toString() {
  return 'LearnPageState.error(status: $status, error: $error)';
}


}

/// @nodoc
abstract mixin class $ErrorLearnPageStateCopyWith<$Res> implements $LearnPageStateCopyWith<$Res> {
  factory $ErrorLearnPageStateCopyWith(ErrorLearnPageState value, $Res Function(ErrorLearnPageState) _then) = _$ErrorLearnPageStateCopyWithImpl;
@useResult
$Res call({
 LearnPageStatus status, String error
});




}
/// @nodoc
class _$ErrorLearnPageStateCopyWithImpl<$Res>
    implements $ErrorLearnPageStateCopyWith<$Res> {
  _$ErrorLearnPageStateCopyWithImpl(this._self, this._then);

  final ErrorLearnPageState _self;
  final $Res Function(ErrorLearnPageState) _then;

/// Create a copy of LearnPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = null,}) {
  return _then(ErrorLearnPageState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LearnPageStatus,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LoadedLearnPageState extends LearnPageState {
  const LoadedLearnPageState({required this.status, required this.chapterIndex, required this.lesson, required final  List<LearnQuestion> questions, required this.questionIndex, required this.progress, required this.comparison, required this.mistakes, required this.startDateTime, this.answer, this.correctAnswer, this.error}): _questions = questions,super._();
  

 final  LearnPageStatus status;
 final  int chapterIndex;
 final  Lesson lesson;
 final  List<LearnQuestion> _questions;
 List<LearnQuestion> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

 final  int questionIndex;
 final  double progress;
 final  bool Function(Object?, Object?) comparison;
 final  int mistakes;
 final  DateTime startDateTime;
 final  Object? answer;
 final  Object? correctAnswer;
 final  String? error;

/// Create a copy of LearnPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedLearnPageStateCopyWith<LoadedLearnPageState> get copyWith => _$LoadedLearnPageStateCopyWithImpl<LoadedLearnPageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedLearnPageState&&(identical(other.status, status) || other.status == status)&&(identical(other.chapterIndex, chapterIndex) || other.chapterIndex == chapterIndex)&&(identical(other.lesson, lesson) || other.lesson == lesson)&&const DeepCollectionEquality().equals(other._questions, _questions)&&(identical(other.questionIndex, questionIndex) || other.questionIndex == questionIndex)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.comparison, comparison) || other.comparison == comparison)&&(identical(other.mistakes, mistakes) || other.mistakes == mistakes)&&(identical(other.startDateTime, startDateTime) || other.startDateTime == startDateTime)&&const DeepCollectionEquality().equals(other.answer, answer)&&const DeepCollectionEquality().equals(other.correctAnswer, correctAnswer)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,chapterIndex,lesson,const DeepCollectionEquality().hash(_questions),questionIndex,progress,comparison,mistakes,startDateTime,const DeepCollectionEquality().hash(answer),const DeepCollectionEquality().hash(correctAnswer),error);

@override
String toString() {
  return 'LearnPageState.loaded(status: $status, chapterIndex: $chapterIndex, lesson: $lesson, questions: $questions, questionIndex: $questionIndex, progress: $progress, comparison: $comparison, mistakes: $mistakes, startDateTime: $startDateTime, answer: $answer, correctAnswer: $correctAnswer, error: $error)';
}


}

/// @nodoc
abstract mixin class $LoadedLearnPageStateCopyWith<$Res> implements $LearnPageStateCopyWith<$Res> {
  factory $LoadedLearnPageStateCopyWith(LoadedLearnPageState value, $Res Function(LoadedLearnPageState) _then) = _$LoadedLearnPageStateCopyWithImpl;
@useResult
$Res call({
 LearnPageStatus status, int chapterIndex, Lesson lesson, List<LearnQuestion> questions, int questionIndex, double progress, bool Function(Object?, Object?) comparison, int mistakes, DateTime startDateTime, Object? answer, Object? correctAnswer, String? error
});


$LessonCopyWith<$Res> get lesson;

}
/// @nodoc
class _$LoadedLearnPageStateCopyWithImpl<$Res>
    implements $LoadedLearnPageStateCopyWith<$Res> {
  _$LoadedLearnPageStateCopyWithImpl(this._self, this._then);

  final LoadedLearnPageState _self;
  final $Res Function(LoadedLearnPageState) _then;

/// Create a copy of LearnPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,Object? chapterIndex = null,Object? lesson = null,Object? questions = null,Object? questionIndex = null,Object? progress = null,Object? comparison = null,Object? mistakes = null,Object? startDateTime = null,Object? answer = freezed,Object? correctAnswer = freezed,Object? error = freezed,}) {
  return _then(LoadedLearnPageState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LearnPageStatus,chapterIndex: null == chapterIndex ? _self.chapterIndex : chapterIndex // ignore: cast_nullable_to_non_nullable
as int,lesson: null == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as Lesson,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<LearnQuestion>,questionIndex: null == questionIndex ? _self.questionIndex : questionIndex // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,comparison: null == comparison ? _self.comparison : comparison // ignore: cast_nullable_to_non_nullable
as bool Function(Object?, Object?),mistakes: null == mistakes ? _self.mistakes : mistakes // ignore: cast_nullable_to_non_nullable
as int,startDateTime: null == startDateTime ? _self.startDateTime : startDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,answer: freezed == answer ? _self.answer : answer ,correctAnswer: freezed == correctAnswer ? _self.correctAnswer : correctAnswer ,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of LearnPageState
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
mixin _$LearnQuestion {

 bool get isRetry;
/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearnQuestionCopyWith<LearnQuestion> get copyWith => _$LearnQuestionCopyWithImpl<LearnQuestion>(this as LearnQuestion, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearnQuestion&&(identical(other.isRetry, isRetry) || other.isRetry == isRetry));
}


@override
int get hashCode => Object.hash(runtimeType,isRetry);

@override
String toString() {
  return 'LearnQuestion(isRetry: $isRetry)';
}


}

/// @nodoc
abstract mixin class $LearnQuestionCopyWith<$Res>  {
  factory $LearnQuestionCopyWith(LearnQuestion value, $Res Function(LearnQuestion) _then) = _$LearnQuestionCopyWithImpl;
@useResult
$Res call({
 bool isRetry
});




}
/// @nodoc
class _$LearnQuestionCopyWithImpl<$Res>
    implements $LearnQuestionCopyWith<$Res> {
  _$LearnQuestionCopyWithImpl(this._self, this._then);

  final LearnQuestion _self;
  final $Res Function(LearnQuestion) _then;

/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isRetry = null,}) {
  return _then(_self.copyWith(
isRetry: null == isRetry ? _self.isRetry : isRetry // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class PlainLearnQuestion extends LearnQuestion {
  const PlainLearnQuestion({required final  List<Widget> children, this.isRetry = false}): _children = children,super._();
  

 final  List<Widget> _children;
 List<Widget> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}

@override@JsonKey() final  bool isRetry;

/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlainLearnQuestionCopyWith<PlainLearnQuestion> get copyWith => _$PlainLearnQuestionCopyWithImpl<PlainLearnQuestion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlainLearnQuestion&&const DeepCollectionEquality().equals(other._children, _children)&&(identical(other.isRetry, isRetry) || other.isRetry == isRetry));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_children),isRetry);

@override
String toString() {
  return 'LearnQuestion.plain(children: $children, isRetry: $isRetry)';
}


}

/// @nodoc
abstract mixin class $PlainLearnQuestionCopyWith<$Res> implements $LearnQuestionCopyWith<$Res> {
  factory $PlainLearnQuestionCopyWith(PlainLearnQuestion value, $Res Function(PlainLearnQuestion) _then) = _$PlainLearnQuestionCopyWithImpl;
@override @useResult
$Res call({
 List<Widget> children, bool isRetry
});




}
/// @nodoc
class _$PlainLearnQuestionCopyWithImpl<$Res>
    implements $PlainLearnQuestionCopyWith<$Res> {
  _$PlainLearnQuestionCopyWithImpl(this._self, this._then);

  final PlainLearnQuestion _self;
  final $Res Function(PlainLearnQuestion) _then;

/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? children = null,Object? isRetry = null,}) {
  return _then(PlainLearnQuestion(
children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<Widget>,isRetry: null == isRetry ? _self.isRetry : isRetry // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class DirectFormulaLearnQuestion extends LearnQuestion {
  const DirectFormulaLearnQuestion({required this.from, required this.to, required final  List<NumericalExpression> choices, required this.answer, this.isRetry = false}): _choices = choices,super._();
  

 final  Unit from;
 final  Unit to;
 final  List<NumericalExpression> _choices;
 List<NumericalExpression> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}

 final  NumericalExpression answer;
@override@JsonKey() final  bool isRetry;

/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DirectFormulaLearnQuestionCopyWith<DirectFormulaLearnQuestion> get copyWith => _$DirectFormulaLearnQuestionCopyWithImpl<DirectFormulaLearnQuestion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DirectFormulaLearnQuestion&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&const DeepCollectionEquality().equals(other._choices, _choices)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.isRetry, isRetry) || other.isRetry == isRetry));
}


@override
int get hashCode => Object.hash(runtimeType,from,to,const DeepCollectionEquality().hash(_choices),answer,isRetry);

@override
String toString() {
  return 'LearnQuestion.directFormula(from: $from, to: $to, choices: $choices, answer: $answer, isRetry: $isRetry)';
}


}

/// @nodoc
abstract mixin class $DirectFormulaLearnQuestionCopyWith<$Res> implements $LearnQuestionCopyWith<$Res> {
  factory $DirectFormulaLearnQuestionCopyWith(DirectFormulaLearnQuestion value, $Res Function(DirectFormulaLearnQuestion) _then) = _$DirectFormulaLearnQuestionCopyWithImpl;
@override @useResult
$Res call({
 Unit from, Unit to, List<NumericalExpression> choices, NumericalExpression answer, bool isRetry
});


$UnitCopyWith<$Res> get from;$UnitCopyWith<$Res> get to;

}
/// @nodoc
class _$DirectFormulaLearnQuestionCopyWithImpl<$Res>
    implements $DirectFormulaLearnQuestionCopyWith<$Res> {
  _$DirectFormulaLearnQuestionCopyWithImpl(this._self, this._then);

  final DirectFormulaLearnQuestion _self;
  final $Res Function(DirectFormulaLearnQuestion) _then;

/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? choices = null,Object? answer = null,Object? isRetry = null,}) {
  return _then(DirectFormulaLearnQuestion(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as Unit,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as Unit,choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<NumericalExpression>,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as NumericalExpression,isRetry: null == isRetry ? _self.isRetry : isRetry // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnitCopyWith<$Res> get from {
  
  return $UnitCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnitCopyWith<$Res> get to {
  
  return $UnitCopyWith<$Res>(_self.to, (value) {
    return _then(_self.copyWith(to: value));
  });
}
}

/// @nodoc


class ImportantNumbersLearnQuestion extends LearnQuestion {
  const ImportantNumbersLearnQuestion({required this.from, required this.to, required final  Set<Set<num>> choices, required final  Set<num> answer, this.isRetry = false}): _choices = choices,_answer = answer,super._();
  

 final  Unit from;
 final  Unit to;
 final  Set<Set<num>> _choices;
 Set<Set<num>> get choices {
  if (_choices is EqualUnmodifiableSetView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_choices);
}

 final  Set<num> _answer;
 Set<num> get answer {
  if (_answer is EqualUnmodifiableSetView) return _answer;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_answer);
}

@override@JsonKey() final  bool isRetry;

/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportantNumbersLearnQuestionCopyWith<ImportantNumbersLearnQuestion> get copyWith => _$ImportantNumbersLearnQuestionCopyWithImpl<ImportantNumbersLearnQuestion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportantNumbersLearnQuestion&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&const DeepCollectionEquality().equals(other._choices, _choices)&&const DeepCollectionEquality().equals(other._answer, _answer)&&(identical(other.isRetry, isRetry) || other.isRetry == isRetry));
}


@override
int get hashCode => Object.hash(runtimeType,from,to,const DeepCollectionEquality().hash(_choices),const DeepCollectionEquality().hash(_answer),isRetry);

@override
String toString() {
  return 'LearnQuestion.importantNumbers(from: $from, to: $to, choices: $choices, answer: $answer, isRetry: $isRetry)';
}


}

/// @nodoc
abstract mixin class $ImportantNumbersLearnQuestionCopyWith<$Res> implements $LearnQuestionCopyWith<$Res> {
  factory $ImportantNumbersLearnQuestionCopyWith(ImportantNumbersLearnQuestion value, $Res Function(ImportantNumbersLearnQuestion) _then) = _$ImportantNumbersLearnQuestionCopyWithImpl;
@override @useResult
$Res call({
 Unit from, Unit to, Set<Set<num>> choices, Set<num> answer, bool isRetry
});


$UnitCopyWith<$Res> get from;$UnitCopyWith<$Res> get to;

}
/// @nodoc
class _$ImportantNumbersLearnQuestionCopyWithImpl<$Res>
    implements $ImportantNumbersLearnQuestionCopyWith<$Res> {
  _$ImportantNumbersLearnQuestionCopyWithImpl(this._self, this._then);

  final ImportantNumbersLearnQuestion _self;
  final $Res Function(ImportantNumbersLearnQuestion) _then;

/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? choices = null,Object? answer = null,Object? isRetry = null,}) {
  return _then(ImportantNumbersLearnQuestion(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as Unit,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as Unit,choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as Set<Set<num>>,answer: null == answer ? _self._answer : answer // ignore: cast_nullable_to_non_nullable
as Set<num>,isRetry: null == isRetry ? _self.isRetry : isRetry // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnitCopyWith<$Res> get from {
  
  return $UnitCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnitCopyWith<$Res> get to {
  
  return $UnitCopyWith<$Res>(_self.to, (value) {
    return _then(_self.copyWith(to: value));
  });
}
}

/// @nodoc


class IndirectStepsLearnQuestion extends LearnQuestion {
  const IndirectStepsLearnQuestion({required this.from, required this.to, required final  List<((Unit, Unit), NumericalExpression)> steps, required final  List<Unit> choices, required final  List<Unit> answer, this.isRetry = false}): _steps = steps,_choices = choices,_answer = answer,super._();
  

 final  Unit from;
 final  Unit to;
 final  List<((Unit, Unit), NumericalExpression)> _steps;
 List<((Unit, Unit), NumericalExpression)> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

 final  List<Unit> _choices;
 List<Unit> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}

 final  List<Unit> _answer;
 List<Unit> get answer {
  if (_answer is EqualUnmodifiableListView) return _answer;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_answer);
}

@override@JsonKey() final  bool isRetry;

/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IndirectStepsLearnQuestionCopyWith<IndirectStepsLearnQuestion> get copyWith => _$IndirectStepsLearnQuestionCopyWithImpl<IndirectStepsLearnQuestion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IndirectStepsLearnQuestion&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&const DeepCollectionEquality().equals(other._steps, _steps)&&const DeepCollectionEquality().equals(other._choices, _choices)&&const DeepCollectionEquality().equals(other._answer, _answer)&&(identical(other.isRetry, isRetry) || other.isRetry == isRetry));
}


@override
int get hashCode => Object.hash(runtimeType,from,to,const DeepCollectionEquality().hash(_steps),const DeepCollectionEquality().hash(_choices),const DeepCollectionEquality().hash(_answer),isRetry);

@override
String toString() {
  return 'LearnQuestion.indirectSteps(from: $from, to: $to, steps: $steps, choices: $choices, answer: $answer, isRetry: $isRetry)';
}


}

/// @nodoc
abstract mixin class $IndirectStepsLearnQuestionCopyWith<$Res> implements $LearnQuestionCopyWith<$Res> {
  factory $IndirectStepsLearnQuestionCopyWith(IndirectStepsLearnQuestion value, $Res Function(IndirectStepsLearnQuestion) _then) = _$IndirectStepsLearnQuestionCopyWithImpl;
@override @useResult
$Res call({
 Unit from, Unit to, List<((Unit, Unit), NumericalExpression)> steps, List<Unit> choices, List<Unit> answer, bool isRetry
});


$UnitCopyWith<$Res> get from;$UnitCopyWith<$Res> get to;

}
/// @nodoc
class _$IndirectStepsLearnQuestionCopyWithImpl<$Res>
    implements $IndirectStepsLearnQuestionCopyWith<$Res> {
  _$IndirectStepsLearnQuestionCopyWithImpl(this._self, this._then);

  final IndirectStepsLearnQuestion _self;
  final $Res Function(IndirectStepsLearnQuestion) _then;

/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? steps = null,Object? choices = null,Object? answer = null,Object? isRetry = null,}) {
  return _then(IndirectStepsLearnQuestion(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as Unit,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as Unit,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<((Unit, Unit), NumericalExpression)>,choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<Unit>,answer: null == answer ? _self._answer : answer // ignore: cast_nullable_to_non_nullable
as List<Unit>,isRetry: null == isRetry ? _self.isRetry : isRetry // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnitCopyWith<$Res> get from {
  
  return $UnitCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnitCopyWith<$Res> get to {
  
  return $UnitCopyWith<$Res>(_self.to, (value) {
    return _then(_self.copyWith(to: value));
  });
}
}

// dart format on
