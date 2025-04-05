// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Conversion {

 String get from; String get to;@JsonKey(toJson: expressionToJson, fromJson: expressionFromJson) Expression get formula;
/// Create a copy of Conversion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversionCopyWith<Conversion> get copyWith => _$ConversionCopyWithImpl<Conversion>(this as Conversion, _$identity);

  /// Serializes this Conversion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Conversion&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.formula, formula) || other.formula == formula));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,formula);

@override
String toString() {
  return 'Conversion(from: $from, to: $to, formula: $formula)';
}


}

/// @nodoc
abstract mixin class $ConversionCopyWith<$Res>  {
  factory $ConversionCopyWith(Conversion value, $Res Function(Conversion) _then) = _$ConversionCopyWithImpl;
@useResult
$Res call({
 String from, String to,@JsonKey(toJson: expressionToJson, fromJson: expressionFromJson) Expression formula
});




}
/// @nodoc
class _$ConversionCopyWithImpl<$Res>
    implements $ConversionCopyWith<$Res> {
  _$ConversionCopyWithImpl(this._self, this._then);

  final Conversion _self;
  final $Res Function(Conversion) _then;

/// Create a copy of Conversion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,Object? formula = null,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,formula: null == formula ? _self.formula : formula // ignore: cast_nullable_to_non_nullable
as Expression,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Conversion implements Conversion {
  const _Conversion({required this.from, required this.to, @JsonKey(toJson: expressionToJson, fromJson: expressionFromJson) required this.formula});
  factory _Conversion.fromJson(Map<String, dynamic> json) => _$ConversionFromJson(json);

@override final  String from;
@override final  String to;
@override@JsonKey(toJson: expressionToJson, fromJson: expressionFromJson) final  Expression formula;

/// Create a copy of Conversion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversionCopyWith<_Conversion> get copyWith => __$ConversionCopyWithImpl<_Conversion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConversionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Conversion&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.formula, formula) || other.formula == formula));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,formula);

@override
String toString() {
  return 'Conversion(from: $from, to: $to, formula: $formula)';
}


}

/// @nodoc
abstract mixin class _$ConversionCopyWith<$Res> implements $ConversionCopyWith<$Res> {
  factory _$ConversionCopyWith(_Conversion value, $Res Function(_Conversion) _then) = __$ConversionCopyWithImpl;
@override @useResult
$Res call({
 String from, String to,@JsonKey(toJson: expressionToJson, fromJson: expressionFromJson) Expression formula
});




}
/// @nodoc
class __$ConversionCopyWithImpl<$Res>
    implements _$ConversionCopyWith<$Res> {
  __$ConversionCopyWithImpl(this._self, this._then);

  final _Conversion _self;
  final $Res Function(_Conversion) _then;

/// Create a copy of Conversion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? formula = null,}) {
  return _then(_Conversion(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,formula: null == formula ? _self.formula : formula // ignore: cast_nullable_to_non_nullable
as Expression,
  ));
}


}

// dart format on
