// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserDataState {

 User? get user; UserDataStatus get status; Map<String, DateTime> get finishedChapters;
/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserDataStateCopyWith<UserDataState> get copyWith => _$UserDataStateCopyWithImpl<UserDataState>(this as UserDataState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserDataState&&(identical(other.user, user) || other.user == user)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.finishedChapters, finishedChapters));
}


@override
int get hashCode => Object.hash(runtimeType,user,status,const DeepCollectionEquality().hash(finishedChapters));

@override
String toString() {
  return 'UserDataState(user: $user, status: $status, finishedChapters: $finishedChapters)';
}


}

/// @nodoc
abstract mixin class $UserDataStateCopyWith<$Res>  {
  factory $UserDataStateCopyWith(UserDataState value, $Res Function(UserDataState) _then) = _$UserDataStateCopyWithImpl;
@useResult
$Res call({
 User? user, UserDataStatus status, Map<String, DateTime> finishedChapters
});




}
/// @nodoc
class _$UserDataStateCopyWithImpl<$Res>
    implements $UserDataStateCopyWith<$Res> {
  _$UserDataStateCopyWithImpl(this._self, this._then);

  final UserDataState _self;
  final $Res Function(UserDataState) _then;

/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = freezed,Object? status = null,Object? finishedChapters = null,}) {
  return _then(_self.copyWith(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserDataStatus,finishedChapters: null == finishedChapters ? _self.finishedChapters : finishedChapters // ignore: cast_nullable_to_non_nullable
as Map<String, DateTime>,
  ));
}

}


/// @nodoc


class _UserDataState extends UserDataState {
  const _UserDataState({required this.user, required this.status, required final  Map<String, DateTime> finishedChapters}): _finishedChapters = finishedChapters,super._();
  

@override final  User? user;
@override final  UserDataStatus status;
 final  Map<String, DateTime> _finishedChapters;
@override Map<String, DateTime> get finishedChapters {
  if (_finishedChapters is EqualUnmodifiableMapView) return _finishedChapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_finishedChapters);
}


/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserDataStateCopyWith<_UserDataState> get copyWith => __$UserDataStateCopyWithImpl<_UserDataState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserDataState&&(identical(other.user, user) || other.user == user)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._finishedChapters, _finishedChapters));
}


@override
int get hashCode => Object.hash(runtimeType,user,status,const DeepCollectionEquality().hash(_finishedChapters));

@override
String toString() {
  return 'UserDataState(user: $user, status: $status, finishedChapters: $finishedChapters)';
}


}

/// @nodoc
abstract mixin class _$UserDataStateCopyWith<$Res> implements $UserDataStateCopyWith<$Res> {
  factory _$UserDataStateCopyWith(_UserDataState value, $Res Function(_UserDataState) _then) = __$UserDataStateCopyWithImpl;
@override @useResult
$Res call({
 User? user, UserDataStatus status, Map<String, DateTime> finishedChapters
});




}
/// @nodoc
class __$UserDataStateCopyWithImpl<$Res>
    implements _$UserDataStateCopyWith<$Res> {
  __$UserDataStateCopyWithImpl(this._self, this._then);

  final _UserDataState _self;
  final $Res Function(_UserDataState) _then;

/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = freezed,Object? status = null,Object? finishedChapters = null,}) {
  return _then(_UserDataState(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserDataStatus,finishedChapters: null == finishedChapters ? _self._finishedChapters : finishedChapters // ignore: cast_nullable_to_non_nullable
as Map<String, DateTime>,
  ));
}


}

// dart format on
