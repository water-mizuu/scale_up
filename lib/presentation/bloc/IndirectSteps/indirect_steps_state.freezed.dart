// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'indirect_steps_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IndirectStepsState {

 IndirectStepsLearnQuestion get question; IndirectStepsStatus get status; List<(int choiceIndex, Unit unit)?> get answers; List<Unit?> get choices;//
 AnimationController get animationController; GlobalKey get parentKey; List<GlobalKey> get answerKeys; List<GlobalKey> get choiceKeys; (Unit, Offset, Offset)? get animation;
/// Create a copy of IndirectStepsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IndirectStepsStateCopyWith<IndirectStepsState> get copyWith => _$IndirectStepsStateCopyWithImpl<IndirectStepsState>(this as IndirectStepsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IndirectStepsState&&const DeepCollectionEquality().equals(other.question, question)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.answers, answers)&&const DeepCollectionEquality().equals(other.choices, choices)&&(identical(other.animationController, animationController) || other.animationController == animationController)&&(identical(other.parentKey, parentKey) || other.parentKey == parentKey)&&const DeepCollectionEquality().equals(other.answerKeys, answerKeys)&&const DeepCollectionEquality().equals(other.choiceKeys, choiceKeys)&&(identical(other.animation, animation) || other.animation == animation));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(question),status,const DeepCollectionEquality().hash(answers),const DeepCollectionEquality().hash(choices),animationController,parentKey,const DeepCollectionEquality().hash(answerKeys),const DeepCollectionEquality().hash(choiceKeys),animation);

@override
String toString() {
  return 'IndirectStepsState(question: $question, status: $status, answers: $answers, choices: $choices, animationController: $animationController, parentKey: $parentKey, answerKeys: $answerKeys, choiceKeys: $choiceKeys, animation: $animation)';
}


}

/// @nodoc
abstract mixin class $IndirectStepsStateCopyWith<$Res>  {
  factory $IndirectStepsStateCopyWith(IndirectStepsState value, $Res Function(IndirectStepsState) _then) = _$IndirectStepsStateCopyWithImpl;
@useResult
$Res call({
 IndirectStepsLearnQuestion question, IndirectStepsStatus status, List<(int choiceIndex, Unit unit)?> answers, List<Unit?> choices, AnimationController animationController, GlobalKey parentKey, List<GlobalKey> answerKeys, List<GlobalKey> choiceKeys, (Unit, Offset, Offset)? animation
});




}
/// @nodoc
class _$IndirectStepsStateCopyWithImpl<$Res>
    implements $IndirectStepsStateCopyWith<$Res> {
  _$IndirectStepsStateCopyWithImpl(this._self, this._then);

  final IndirectStepsState _self;
  final $Res Function(IndirectStepsState) _then;

/// Create a copy of IndirectStepsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = freezed,Object? status = null,Object? answers = null,Object? choices = null,Object? animationController = null,Object? parentKey = null,Object? answerKeys = null,Object? choiceKeys = null,Object? animation = freezed,}) {
  return _then(_self.copyWith(
question: freezed == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as IndirectStepsLearnQuestion,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as IndirectStepsStatus,answers: null == answers ? _self.answers : answers // ignore: cast_nullable_to_non_nullable
as List<(int choiceIndex, Unit unit)?>,choices: null == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as List<Unit?>,animationController: null == animationController ? _self.animationController : animationController // ignore: cast_nullable_to_non_nullable
as AnimationController,parentKey: null == parentKey ? _self.parentKey : parentKey // ignore: cast_nullable_to_non_nullable
as GlobalKey,answerKeys: null == answerKeys ? _self.answerKeys : answerKeys // ignore: cast_nullable_to_non_nullable
as List<GlobalKey>,choiceKeys: null == choiceKeys ? _self.choiceKeys : choiceKeys // ignore: cast_nullable_to_non_nullable
as List<GlobalKey>,animation: freezed == animation ? _self.animation : animation // ignore: cast_nullable_to_non_nullable
as (Unit, Offset, Offset)?,
  ));
}

}


/// @nodoc


class _IndirectStepsState extends IndirectStepsState {
  const _IndirectStepsState({required this.question, required this.status, required final  List<(int choiceIndex, Unit unit)?> answers, required final  List<Unit?> choices, required this.animationController, required this.parentKey, required final  List<GlobalKey> answerKeys, required final  List<GlobalKey> choiceKeys, required this.animation}): _answers = answers,_choices = choices,_answerKeys = answerKeys,_choiceKeys = choiceKeys,super._();
  

@override final  IndirectStepsLearnQuestion question;
@override final  IndirectStepsStatus status;
 final  List<(int choiceIndex, Unit unit)?> _answers;
@override List<(int choiceIndex, Unit unit)?> get answers {
  if (_answers is EqualUnmodifiableListView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_answers);
}

 final  List<Unit?> _choices;
@override List<Unit?> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}

//
@override final  AnimationController animationController;
@override final  GlobalKey parentKey;
 final  List<GlobalKey> _answerKeys;
@override List<GlobalKey> get answerKeys {
  if (_answerKeys is EqualUnmodifiableListView) return _answerKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_answerKeys);
}

 final  List<GlobalKey> _choiceKeys;
@override List<GlobalKey> get choiceKeys {
  if (_choiceKeys is EqualUnmodifiableListView) return _choiceKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choiceKeys);
}

@override final  (Unit, Offset, Offset)? animation;

/// Create a copy of IndirectStepsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IndirectStepsStateCopyWith<_IndirectStepsState> get copyWith => __$IndirectStepsStateCopyWithImpl<_IndirectStepsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IndirectStepsState&&const DeepCollectionEquality().equals(other.question, question)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._answers, _answers)&&const DeepCollectionEquality().equals(other._choices, _choices)&&(identical(other.animationController, animationController) || other.animationController == animationController)&&(identical(other.parentKey, parentKey) || other.parentKey == parentKey)&&const DeepCollectionEquality().equals(other._answerKeys, _answerKeys)&&const DeepCollectionEquality().equals(other._choiceKeys, _choiceKeys)&&(identical(other.animation, animation) || other.animation == animation));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(question),status,const DeepCollectionEquality().hash(_answers),const DeepCollectionEquality().hash(_choices),animationController,parentKey,const DeepCollectionEquality().hash(_answerKeys),const DeepCollectionEquality().hash(_choiceKeys),animation);

@override
String toString() {
  return 'IndirectStepsState(question: $question, status: $status, answers: $answers, choices: $choices, animationController: $animationController, parentKey: $parentKey, answerKeys: $answerKeys, choiceKeys: $choiceKeys, animation: $animation)';
}


}

/// @nodoc
abstract mixin class _$IndirectStepsStateCopyWith<$Res> implements $IndirectStepsStateCopyWith<$Res> {
  factory _$IndirectStepsStateCopyWith(_IndirectStepsState value, $Res Function(_IndirectStepsState) _then) = __$IndirectStepsStateCopyWithImpl;
@override @useResult
$Res call({
 IndirectStepsLearnQuestion question, IndirectStepsStatus status, List<(int choiceIndex, Unit unit)?> answers, List<Unit?> choices, AnimationController animationController, GlobalKey parentKey, List<GlobalKey> answerKeys, List<GlobalKey> choiceKeys, (Unit, Offset, Offset)? animation
});




}
/// @nodoc
class __$IndirectStepsStateCopyWithImpl<$Res>
    implements _$IndirectStepsStateCopyWith<$Res> {
  __$IndirectStepsStateCopyWithImpl(this._self, this._then);

  final _IndirectStepsState _self;
  final $Res Function(_IndirectStepsState) _then;

/// Create a copy of IndirectStepsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = freezed,Object? status = null,Object? answers = null,Object? choices = null,Object? animationController = null,Object? parentKey = null,Object? answerKeys = null,Object? choiceKeys = null,Object? animation = freezed,}) {
  return _then(_IndirectStepsState(
question: freezed == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as IndirectStepsLearnQuestion,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as IndirectStepsStatus,answers: null == answers ? _self._answers : answers // ignore: cast_nullable_to_non_nullable
as List<(int choiceIndex, Unit unit)?>,choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<Unit?>,animationController: null == animationController ? _self.animationController : animationController // ignore: cast_nullable_to_non_nullable
as AnimationController,parentKey: null == parentKey ? _self.parentKey : parentKey // ignore: cast_nullable_to_non_nullable
as GlobalKey,answerKeys: null == answerKeys ? _self._answerKeys : answerKeys // ignore: cast_nullable_to_non_nullable
as List<GlobalKey>,choiceKeys: null == choiceKeys ? _self._choiceKeys : choiceKeys // ignore: cast_nullable_to_non_nullable
as List<GlobalKey>,animation: freezed == animation ? _self.animation : animation // ignore: cast_nullable_to_non_nullable
as (Unit, Offset, Offset)?,
  ));
}


}

// dart format on
