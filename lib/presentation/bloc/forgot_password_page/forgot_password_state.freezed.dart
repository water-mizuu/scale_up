// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgot_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ForgotPasswordState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState()';
}


}

/// @nodoc
class $ForgotPasswordStateCopyWith<$Res>  {
$ForgotPasswordStateCopyWith(ForgotPasswordState _, $Res Function(ForgotPasswordState) __);
}


/// @nodoc


class InitialForgotPasswordState extends ForgotPasswordState {
  const InitialForgotPasswordState({required this.email}): super._();
  

 final  String email;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitialForgotPasswordStateCopyWith<InitialForgotPasswordState> get copyWith => _$InitialForgotPasswordStateCopyWithImpl<InitialForgotPasswordState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialForgotPasswordState&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'ForgotPasswordState.initial(email: $email)';
}


}

/// @nodoc
abstract mixin class $InitialForgotPasswordStateCopyWith<$Res> implements $ForgotPasswordStateCopyWith<$Res> {
  factory $InitialForgotPasswordStateCopyWith(InitialForgotPasswordState value, $Res Function(InitialForgotPasswordState) _then) = _$InitialForgotPasswordStateCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$InitialForgotPasswordStateCopyWithImpl<$Res>
    implements $InitialForgotPasswordStateCopyWith<$Res> {
  _$InitialForgotPasswordStateCopyWithImpl(this._self, this._then);

  final InitialForgotPasswordState _self;
  final $Res Function(InitialForgotPasswordState) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(InitialForgotPasswordState(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SendingForgotPasswordState extends ForgotPasswordState {
  const SendingForgotPasswordState({required this.email}): super._();
  

 final  String email;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendingForgotPasswordStateCopyWith<SendingForgotPasswordState> get copyWith => _$SendingForgotPasswordStateCopyWithImpl<SendingForgotPasswordState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendingForgotPasswordState&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'ForgotPasswordState.sending(email: $email)';
}


}

/// @nodoc
abstract mixin class $SendingForgotPasswordStateCopyWith<$Res> implements $ForgotPasswordStateCopyWith<$Res> {
  factory $SendingForgotPasswordStateCopyWith(SendingForgotPasswordState value, $Res Function(SendingForgotPasswordState) _then) = _$SendingForgotPasswordStateCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$SendingForgotPasswordStateCopyWithImpl<$Res>
    implements $SendingForgotPasswordStateCopyWith<$Res> {
  _$SendingForgotPasswordStateCopyWithImpl(this._self, this._then);

  final SendingForgotPasswordState _self;
  final $Res Function(SendingForgotPasswordState) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(SendingForgotPasswordState(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SuccessForgotPasswordState extends ForgotPasswordState {
  const SuccessForgotPasswordState(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessForgotPasswordState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState.success()';
}


}




// dart format on
