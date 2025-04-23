// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'context_dialog_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContextDialogState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContextDialogState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContextDialogState()';
}


}

/// @nodoc
class $ContextDialogStateCopyWith<$Res>  {
$ContextDialogStateCopyWith(ContextDialogState _, $Res Function(ContextDialogState) __);
}


/// @nodoc


class ShowConfirmationDialog extends ContextDialogState {
  const ShowConfirmationDialog({required this.title, required this.message, this.confirmButtonColor = Colors.blueAccent, this.cancelButtonColor = Colors.redAccent, this.confirmButtonText = "Confirm", this.cancelButtonText = "Cancel", required this.onConfirmPressed, required this.onCancelPressed}): super._();
  

 final  String title;
 final  String message;
@JsonKey() final  Color confirmButtonColor;
@JsonKey() final  Color cancelButtonColor;
@JsonKey() final  String confirmButtonText;
@JsonKey() final  String cancelButtonText;
 final  void Function() onConfirmPressed;
 final  void Function() onCancelPressed;

/// Create a copy of ContextDialogState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShowConfirmationDialogCopyWith<ShowConfirmationDialog> get copyWith => _$ShowConfirmationDialogCopyWithImpl<ShowConfirmationDialog>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShowConfirmationDialog&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.confirmButtonColor, confirmButtonColor) || other.confirmButtonColor == confirmButtonColor)&&(identical(other.cancelButtonColor, cancelButtonColor) || other.cancelButtonColor == cancelButtonColor)&&(identical(other.confirmButtonText, confirmButtonText) || other.confirmButtonText == confirmButtonText)&&(identical(other.cancelButtonText, cancelButtonText) || other.cancelButtonText == cancelButtonText)&&(identical(other.onConfirmPressed, onConfirmPressed) || other.onConfirmPressed == onConfirmPressed)&&(identical(other.onCancelPressed, onCancelPressed) || other.onCancelPressed == onCancelPressed));
}


@override
int get hashCode => Object.hash(runtimeType,title,message,confirmButtonColor,cancelButtonColor,confirmButtonText,cancelButtonText,onConfirmPressed,onCancelPressed);

@override
String toString() {
  return 'ContextDialogState.showingConfirmationDialog(title: $title, message: $message, confirmButtonColor: $confirmButtonColor, cancelButtonColor: $cancelButtonColor, confirmButtonText: $confirmButtonText, cancelButtonText: $cancelButtonText, onConfirmPressed: $onConfirmPressed, onCancelPressed: $onCancelPressed)';
}


}

/// @nodoc
abstract mixin class $ShowConfirmationDialogCopyWith<$Res> implements $ContextDialogStateCopyWith<$Res> {
  factory $ShowConfirmationDialogCopyWith(ShowConfirmationDialog value, $Res Function(ShowConfirmationDialog) _then) = _$ShowConfirmationDialogCopyWithImpl;
@useResult
$Res call({
 String title, String message, Color confirmButtonColor, Color cancelButtonColor, String confirmButtonText, String cancelButtonText, void Function() onConfirmPressed, void Function() onCancelPressed
});




}
/// @nodoc
class _$ShowConfirmationDialogCopyWithImpl<$Res>
    implements $ShowConfirmationDialogCopyWith<$Res> {
  _$ShowConfirmationDialogCopyWithImpl(this._self, this._then);

  final ShowConfirmationDialog _self;
  final $Res Function(ShowConfirmationDialog) _then;

/// Create a copy of ContextDialogState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,Object? message = null,Object? confirmButtonColor = null,Object? cancelButtonColor = null,Object? confirmButtonText = null,Object? cancelButtonText = null,Object? onConfirmPressed = null,Object? onCancelPressed = null,}) {
  return _then(ShowConfirmationDialog(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,confirmButtonColor: null == confirmButtonColor ? _self.confirmButtonColor : confirmButtonColor // ignore: cast_nullable_to_non_nullable
as Color,cancelButtonColor: null == cancelButtonColor ? _self.cancelButtonColor : cancelButtonColor // ignore: cast_nullable_to_non_nullable
as Color,confirmButtonText: null == confirmButtonText ? _self.confirmButtonText : confirmButtonText // ignore: cast_nullable_to_non_nullable
as String,cancelButtonText: null == cancelButtonText ? _self.cancelButtonText : cancelButtonText // ignore: cast_nullable_to_non_nullable
as String,onConfirmPressed: null == onConfirmPressed ? _self.onConfirmPressed : onConfirmPressed // ignore: cast_nullable_to_non_nullable
as void Function(),onCancelPressed: null == onCancelPressed ? _self.onCancelPressed : onCancelPressed // ignore: cast_nullable_to_non_nullable
as void Function(),
  ));
}


}

/// @nodoc


class ShowInfoDialog extends ContextDialogState {
  const ShowInfoDialog({required this.title, required this.message, required this.buttonText, required this.buttonColor, required this.onPressed}): super._();
  

 final  String title;
 final  String message;
 final  String buttonText;
 final  Color buttonColor;
 final   Function() onPressed;

/// Create a copy of ContextDialogState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShowInfoDialogCopyWith<ShowInfoDialog> get copyWith => _$ShowInfoDialogCopyWithImpl<ShowInfoDialog>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShowInfoDialog&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.buttonText, buttonText) || other.buttonText == buttonText)&&(identical(other.buttonColor, buttonColor) || other.buttonColor == buttonColor)&&(identical(other.onPressed, onPressed) || other.onPressed == onPressed));
}


@override
int get hashCode => Object.hash(runtimeType,title,message,buttonText,buttonColor,onPressed);

@override
String toString() {
  return 'ContextDialogState.showingInfoDialog(title: $title, message: $message, buttonText: $buttonText, buttonColor: $buttonColor, onPressed: $onPressed)';
}


}

/// @nodoc
abstract mixin class $ShowInfoDialogCopyWith<$Res> implements $ContextDialogStateCopyWith<$Res> {
  factory $ShowInfoDialogCopyWith(ShowInfoDialog value, $Res Function(ShowInfoDialog) _then) = _$ShowInfoDialogCopyWithImpl;
@useResult
$Res call({
 String title, String message, String buttonText, Color buttonColor,  Function() onPressed
});




}
/// @nodoc
class _$ShowInfoDialogCopyWithImpl<$Res>
    implements $ShowInfoDialogCopyWith<$Res> {
  _$ShowInfoDialogCopyWithImpl(this._self, this._then);

  final ShowInfoDialog _self;
  final $Res Function(ShowInfoDialog) _then;

/// Create a copy of ContextDialogState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,Object? message = null,Object? buttonText = null,Object? buttonColor = null,Object? onPressed = null,}) {
  return _then(ShowInfoDialog(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,buttonText: null == buttonText ? _self.buttonText : buttonText // ignore: cast_nullable_to_non_nullable
as String,buttonColor: null == buttonColor ? _self.buttonColor : buttonColor // ignore: cast_nullable_to_non_nullable
as Color,onPressed: null == onPressed ? _self.onPressed : onPressed // ignore: cast_nullable_to_non_nullable
as  Function(),
  ));
}


}

/// @nodoc


class HiddenConfirmationDialog extends ContextDialogState {
  const HiddenConfirmationDialog(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HiddenConfirmationDialog);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContextDialogState.hidden()';
}


}




// dart format on
