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





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IndirectStepsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'IndirectStepsState()';
}


}

/// @nodoc
class $IndirectStepsStateCopyWith<$Res>  {
$IndirectStepsStateCopyWith(IndirectStepsState _, $Res Function(IndirectStepsState) __);
}


/// @nodoc


class BlankIndirectStepsState extends IndirectStepsState {
  const BlankIndirectStepsState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlankIndirectStepsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'IndirectStepsState.blank()';
}


}




/// @nodoc


class ActiveIndirectStepsState extends IndirectStepsState {
  const ActiveIndirectStepsState({required this.question, required this.status, required final  List<(int choiceIndex, Unit unit)?> answers, required final  List<Unit?> choices, required this.animationController, required this.parentKey, required final  List<GlobalKey> answerKeys, required final  List<GlobalKey> choiceKeys, required this.animation}): _answers = answers,_choices = choices,_answerKeys = answerKeys,_choiceKeys = choiceKeys,super._();
  

 final  IndirectStepsLearnQuestion question;
 final  IndirectStepsStatus status;
 final  List<(int choiceIndex, Unit unit)?> _answers;
 List<(int choiceIndex, Unit unit)?> get answers {
  if (_answers is EqualUnmodifiableListView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_answers);
}

 final  List<Unit?> _choices;
 List<Unit?> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}

//
 final  AnimationController animationController;
 final  GlobalKey parentKey;
 final  List<GlobalKey> _answerKeys;
 List<GlobalKey> get answerKeys {
  if (_answerKeys is EqualUnmodifiableListView) return _answerKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_answerKeys);
}

 final  List<GlobalKey> _choiceKeys;
 List<GlobalKey> get choiceKeys {
  if (_choiceKeys is EqualUnmodifiableListView) return _choiceKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choiceKeys);
}

 final  (Unit, Offset, Offset)? animation;

/// Create a copy of IndirectStepsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveIndirectStepsStateCopyWith<ActiveIndirectStepsState> get copyWith => _$ActiveIndirectStepsStateCopyWithImpl<ActiveIndirectStepsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveIndirectStepsState&&const DeepCollectionEquality().equals(other.question, question)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._answers, _answers)&&const DeepCollectionEquality().equals(other._choices, _choices)&&(identical(other.animationController, animationController) || other.animationController == animationController)&&(identical(other.parentKey, parentKey) || other.parentKey == parentKey)&&const DeepCollectionEquality().equals(other._answerKeys, _answerKeys)&&const DeepCollectionEquality().equals(other._choiceKeys, _choiceKeys)&&(identical(other.animation, animation) || other.animation == animation));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(question),status,const DeepCollectionEquality().hash(_answers),const DeepCollectionEquality().hash(_choices),animationController,parentKey,const DeepCollectionEquality().hash(_answerKeys),const DeepCollectionEquality().hash(_choiceKeys),animation);

@override
String toString() {
  return 'IndirectStepsState.active(question: $question, status: $status, answers: $answers, choices: $choices, animationController: $animationController, parentKey: $parentKey, answerKeys: $answerKeys, choiceKeys: $choiceKeys, animation: $animation)';
}


}

/// @nodoc
abstract mixin class $ActiveIndirectStepsStateCopyWith<$Res> implements $IndirectStepsStateCopyWith<$Res> {
  factory $ActiveIndirectStepsStateCopyWith(ActiveIndirectStepsState value, $Res Function(ActiveIndirectStepsState) _then) = _$ActiveIndirectStepsStateCopyWithImpl;
@useResult
$Res call({
 IndirectStepsLearnQuestion question, IndirectStepsStatus status, List<(int choiceIndex, Unit unit)?> answers, List<Unit?> choices, AnimationController animationController, GlobalKey parentKey, List<GlobalKey> answerKeys, List<GlobalKey> choiceKeys, (Unit, Offset, Offset)? animation
});




}
/// @nodoc
class _$ActiveIndirectStepsStateCopyWithImpl<$Res>
    implements $ActiveIndirectStepsStateCopyWith<$Res> {
  _$ActiveIndirectStepsStateCopyWithImpl(this._self, this._then);

  final ActiveIndirectStepsState _self;
  final $Res Function(ActiveIndirectStepsState) _then;

/// Create a copy of IndirectStepsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? question = freezed,Object? status = null,Object? answers = null,Object? choices = null,Object? animationController = null,Object? parentKey = null,Object? answerKeys = null,Object? choiceKeys = null,Object? animation = freezed,}) {
  return _then(ActiveIndirectStepsState(
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
