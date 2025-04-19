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

 LearnPageStatus get status;
/// Create a copy of LearnPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearnPageStateCopyWith<LearnPageState> get copyWith => _$LearnPageStateCopyWithImpl<LearnPageState>(this as LearnPageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearnPageState&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'LearnPageState(status: $status)';
}


}

/// @nodoc
abstract mixin class $LearnPageStateCopyWith<$Res>  {
  factory $LearnPageStateCopyWith(LearnPageState value, $Res Function(LearnPageState) _then) = _$LearnPageStateCopyWithImpl;
@useResult
$Res call({
 LearnPageStatus status
});




}
/// @nodoc
class _$LearnPageStateCopyWithImpl<$Res>
    implements $LearnPageStateCopyWith<$Res> {
  _$LearnPageStateCopyWithImpl(this._self, this._then);

  final LearnPageState _self;
  final $Res Function(LearnPageState) _then;

/// Create a copy of LearnPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LearnPageStatus,
  ));
}

}


/// @nodoc


class LoadingLearnPageState extends LearnPageState {
  const LoadingLearnPageState({required this.status, required this.lesson, required this.chapterIndex}): super._();
  

@override final  LearnPageStatus status;
 final  Future<Lesson?> lesson;
 final  int chapterIndex;

/// Create a copy of LearnPageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
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
@override @useResult
$Res call({
 LearnPageStatus status, Future<Lesson?> lesson, int chapterIndex
});




}
/// @nodoc
class _$LoadingLearnPageStateCopyWithImpl<$Res>
    implements $LoadingLearnPageStateCopyWith<$Res> {
  _$LoadingLearnPageStateCopyWithImpl(this._self, this._then);

  final LoadingLearnPageState _self;
  final $Res Function(LoadingLearnPageState) _then;

/// Create a copy of LearnPageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? lesson = null,Object? chapterIndex = null,}) {
  return _then(LoadingLearnPageState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LearnPageStatus,lesson: null == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as Future<Lesson?>,chapterIndex: null == chapterIndex ? _self.chapterIndex : chapterIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ErrorLearnPageState extends LearnPageState {
  const ErrorLearnPageState({required this.status, required this.error}): super._();
  

@override final  LearnPageStatus status;
 final  String error;

/// Create a copy of LearnPageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
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
@override @useResult
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
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = null,}) {
  return _then(ErrorLearnPageState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LearnPageStatus,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LoadedLearnPageState extends LearnPageState {
  const LoadedLearnPageState({required this.status, required this.chapterIndex, required this.lesson, required final  List<LearnQuestion> questions, required this.questionIndex, required this.progress, this.answer, this.correctAnswer, this.error}): _questions = questions,super._();
  

@override final  LearnPageStatus status;
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
 final  Object? answer;
 final  Object? correctAnswer;
 final  String? error;

/// Create a copy of LearnPageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedLearnPageStateCopyWith<LoadedLearnPageState> get copyWith => _$LoadedLearnPageStateCopyWithImpl<LoadedLearnPageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedLearnPageState&&(identical(other.status, status) || other.status == status)&&(identical(other.chapterIndex, chapterIndex) || other.chapterIndex == chapterIndex)&&(identical(other.lesson, lesson) || other.lesson == lesson)&&const DeepCollectionEquality().equals(other._questions, _questions)&&(identical(other.questionIndex, questionIndex) || other.questionIndex == questionIndex)&&(identical(other.progress, progress) || other.progress == progress)&&const DeepCollectionEquality().equals(other.answer, answer)&&const DeepCollectionEquality().equals(other.correctAnswer, correctAnswer)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,chapterIndex,lesson,const DeepCollectionEquality().hash(_questions),questionIndex,progress,const DeepCollectionEquality().hash(answer),const DeepCollectionEquality().hash(correctAnswer),error);

@override
String toString() {
  return 'LearnPageState.loaded(status: $status, chapterIndex: $chapterIndex, lesson: $lesson, questions: $questions, questionIndex: $questionIndex, progress: $progress, answer: $answer, correctAnswer: $correctAnswer, error: $error)';
}


}

/// @nodoc
abstract mixin class $LoadedLearnPageStateCopyWith<$Res> implements $LearnPageStateCopyWith<$Res> {
  factory $LoadedLearnPageStateCopyWith(LoadedLearnPageState value, $Res Function(LoadedLearnPageState) _then) = _$LoadedLearnPageStateCopyWithImpl;
@override @useResult
$Res call({
 LearnPageStatus status, int chapterIndex, Lesson lesson, List<LearnQuestion> questions, int questionIndex, double progress, Object? answer, Object? correctAnswer, String? error
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
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? chapterIndex = null,Object? lesson = null,Object? questions = null,Object? questionIndex = null,Object? progress = null,Object? answer = freezed,Object? correctAnswer = freezed,Object? error = freezed,}) {
  return _then(LoadedLearnPageState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LearnPageStatus,chapterIndex: null == chapterIndex ? _self.chapterIndex : chapterIndex // ignore: cast_nullable_to_non_nullable
as int,lesson: null == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as Lesson,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<LearnQuestion>,questionIndex: null == questionIndex ? _self.questionIndex : questionIndex // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,answer: freezed == answer ? _self.answer : answer ,correctAnswer: freezed == correctAnswer ? _self.correctAnswer : correctAnswer ,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
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

 Unit get from; Unit get to; List<Object> get choices; Object get answer;
/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearnQuestionCopyWith<LearnQuestion> get copyWith => _$LearnQuestionCopyWithImpl<LearnQuestion>(this as LearnQuestion, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearnQuestion&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&const DeepCollectionEquality().equals(other.choices, choices)&&const DeepCollectionEquality().equals(other.answer, answer));
}


@override
int get hashCode => Object.hash(runtimeType,from,to,const DeepCollectionEquality().hash(choices),const DeepCollectionEquality().hash(answer));

@override
String toString() {
  return 'LearnQuestion(from: $from, to: $to, choices: $choices, answer: $answer)';
}


}

/// @nodoc
abstract mixin class $LearnQuestionCopyWith<$Res>  {
  factory $LearnQuestionCopyWith(LearnQuestion value, $Res Function(LearnQuestion) _then) = _$LearnQuestionCopyWithImpl;
@useResult
$Res call({
 Unit from, Unit to
});


$UnitCopyWith<$Res> get from;$UnitCopyWith<$Res> get to;

}
/// @nodoc
class _$LearnQuestionCopyWithImpl<$Res>
    implements $LearnQuestionCopyWith<$Res> {
  _$LearnQuestionCopyWithImpl(this._self, this._then);

  final LearnQuestion _self;
  final $Res Function(LearnQuestion) _then;

/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as Unit,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as Unit,
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


class DirectFormulaLearnQuestion extends LearnQuestion {
  const DirectFormulaLearnQuestion({required this.from, required this.to, required final  List<Expression> choices, required this.answer}): _choices = choices,super._();
  

@override final  Unit from;
@override final  Unit to;
 final  List<Expression> _choices;
@override List<Expression> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}

@override final  Expression answer;

/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DirectFormulaLearnQuestionCopyWith<DirectFormulaLearnQuestion> get copyWith => _$DirectFormulaLearnQuestionCopyWithImpl<DirectFormulaLearnQuestion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DirectFormulaLearnQuestion&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&const DeepCollectionEquality().equals(other._choices, _choices)&&(identical(other.answer, answer) || other.answer == answer));
}


@override
int get hashCode => Object.hash(runtimeType,from,to,const DeepCollectionEquality().hash(_choices),answer);

@override
String toString() {
  return 'LearnQuestion.directFormula(from: $from, to: $to, choices: $choices, answer: $answer)';
}


}

/// @nodoc
abstract mixin class $DirectFormulaLearnQuestionCopyWith<$Res> implements $LearnQuestionCopyWith<$Res> {
  factory $DirectFormulaLearnQuestionCopyWith(DirectFormulaLearnQuestion value, $Res Function(DirectFormulaLearnQuestion) _then) = _$DirectFormulaLearnQuestionCopyWithImpl;
@override @useResult
$Res call({
 Unit from, Unit to, List<Expression> choices, Expression answer
});


@override $UnitCopyWith<$Res> get from;@override $UnitCopyWith<$Res> get to;

}
/// @nodoc
class _$DirectFormulaLearnQuestionCopyWithImpl<$Res>
    implements $DirectFormulaLearnQuestionCopyWith<$Res> {
  _$DirectFormulaLearnQuestionCopyWithImpl(this._self, this._then);

  final DirectFormulaLearnQuestion _self;
  final $Res Function(DirectFormulaLearnQuestion) _then;

/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? choices = null,Object? answer = null,}) {
  return _then(DirectFormulaLearnQuestion(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as Unit,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as Unit,choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<Expression>,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as Expression,
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
  const ImportantNumbersLearnQuestion({required this.from, required this.to, required final  List<Expression> choices, required final  List<num> answer}): _choices = choices,_answer = answer,super._();
  

@override final  Unit from;
@override final  Unit to;
 final  List<Expression> _choices;
@override List<Expression> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}

 final  List<num> _answer;
@override List<num> get answer {
  if (_answer is EqualUnmodifiableListView) return _answer;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_answer);
}


/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportantNumbersLearnQuestionCopyWith<ImportantNumbersLearnQuestion> get copyWith => _$ImportantNumbersLearnQuestionCopyWithImpl<ImportantNumbersLearnQuestion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportantNumbersLearnQuestion&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&const DeepCollectionEquality().equals(other._choices, _choices)&&const DeepCollectionEquality().equals(other._answer, _answer));
}


@override
int get hashCode => Object.hash(runtimeType,from,to,const DeepCollectionEquality().hash(_choices),const DeepCollectionEquality().hash(_answer));

@override
String toString() {
  return 'LearnQuestion.importantNumbers(from: $from, to: $to, choices: $choices, answer: $answer)';
}


}

/// @nodoc
abstract mixin class $ImportantNumbersLearnQuestionCopyWith<$Res> implements $LearnQuestionCopyWith<$Res> {
  factory $ImportantNumbersLearnQuestionCopyWith(ImportantNumbersLearnQuestion value, $Res Function(ImportantNumbersLearnQuestion) _then) = _$ImportantNumbersLearnQuestionCopyWithImpl;
@override @useResult
$Res call({
 Unit from, Unit to, List<Expression> choices, List<num> answer
});


@override $UnitCopyWith<$Res> get from;@override $UnitCopyWith<$Res> get to;

}
/// @nodoc
class _$ImportantNumbersLearnQuestionCopyWithImpl<$Res>
    implements $ImportantNumbersLearnQuestionCopyWith<$Res> {
  _$ImportantNumbersLearnQuestionCopyWithImpl(this._self, this._then);

  final ImportantNumbersLearnQuestion _self;
  final $Res Function(ImportantNumbersLearnQuestion) _then;

/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? choices = null,Object? answer = null,}) {
  return _then(ImportantNumbersLearnQuestion(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as Unit,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as Unit,choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<Expression>,answer: null == answer ? _self._answer : answer // ignore: cast_nullable_to_non_nullable
as List<num>,
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
  const IndirectStepsLearnQuestion({required this.from, required this.to, required final  List<((Unit, Unit), Expression)> steps, required final  List<Unit> choices, required final  List<Object> answer}): _steps = steps,_choices = choices,_answer = answer,super._();
  

@override final  Unit from;
@override final  Unit to;
 final  List<((Unit, Unit), Expression)> _steps;
 List<((Unit, Unit), Expression)> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

 final  List<Unit> _choices;
@override List<Unit> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}

 final  List<Object> _answer;
@override List<Object> get answer {
  if (_answer is EqualUnmodifiableListView) return _answer;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_answer);
}


/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IndirectStepsLearnQuestionCopyWith<IndirectStepsLearnQuestion> get copyWith => _$IndirectStepsLearnQuestionCopyWithImpl<IndirectStepsLearnQuestion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IndirectStepsLearnQuestion&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&const DeepCollectionEquality().equals(other._steps, _steps)&&const DeepCollectionEquality().equals(other._choices, _choices)&&const DeepCollectionEquality().equals(other._answer, _answer));
}


@override
int get hashCode => Object.hash(runtimeType,from,to,const DeepCollectionEquality().hash(_steps),const DeepCollectionEquality().hash(_choices),const DeepCollectionEquality().hash(_answer));

@override
String toString() {
  return 'LearnQuestion.indirectSteps(from: $from, to: $to, steps: $steps, choices: $choices, answer: $answer)';
}


}

/// @nodoc
abstract mixin class $IndirectStepsLearnQuestionCopyWith<$Res> implements $LearnQuestionCopyWith<$Res> {
  factory $IndirectStepsLearnQuestionCopyWith(IndirectStepsLearnQuestion value, $Res Function(IndirectStepsLearnQuestion) _then) = _$IndirectStepsLearnQuestionCopyWithImpl;
@override @useResult
$Res call({
 Unit from, Unit to, List<((Unit, Unit), Expression)> steps, List<Unit> choices, List<Object> answer
});


@override $UnitCopyWith<$Res> get from;@override $UnitCopyWith<$Res> get to;

}
/// @nodoc
class _$IndirectStepsLearnQuestionCopyWithImpl<$Res>
    implements $IndirectStepsLearnQuestionCopyWith<$Res> {
  _$IndirectStepsLearnQuestionCopyWithImpl(this._self, this._then);

  final IndirectStepsLearnQuestion _self;
  final $Res Function(IndirectStepsLearnQuestion) _then;

/// Create a copy of LearnQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? steps = null,Object? choices = null,Object? answer = null,}) {
  return _then(IndirectStepsLearnQuestion(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as Unit,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as Unit,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<((Unit, Unit), Expression)>,choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<Unit>,answer: null == answer ? _self._answer : answer // ignore: cast_nullable_to_non_nullable
as List<Object>,
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
