// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template_part.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TemplatePart implements DiagnosticableTreeMixin {

 String get type; List<String> get variants;
/// Create a copy of TemplatePart
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TemplatePartCopyWith<TemplatePart> get copyWith => _$TemplatePartCopyWithImpl<TemplatePart>(this as TemplatePart, _$identity);

  /// Serializes this TemplatePart to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TemplatePart'))
    ..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('variants', variants));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TemplatePart&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.variants, variants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(variants));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TemplatePart(type: $type, variants: $variants)';
}


}

/// @nodoc
abstract mixin class $TemplatePartCopyWith<$Res>  {
  factory $TemplatePartCopyWith(TemplatePart value, $Res Function(TemplatePart) _then) = _$TemplatePartCopyWithImpl;
@useResult
$Res call({
 String type, List<String> variants
});




}
/// @nodoc
class _$TemplatePartCopyWithImpl<$Res>
    implements $TemplatePartCopyWith<$Res> {
  _$TemplatePartCopyWithImpl(this._self, this._then);

  final TemplatePart _self;
  final $Res Function(TemplatePart) _then;

/// Create a copy of TemplatePart
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? variants = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,variants: null == variants ? _self.variants : variants // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TemplatePart extends TemplatePart with DiagnosticableTreeMixin {
  const _TemplatePart({required this.type, required final  List<String> variants}): _variants = variants,super._();
  factory _TemplatePart.fromJson(Map<String, dynamic> json) => _$TemplatePartFromJson(json);

@override final  String type;
 final  List<String> _variants;
@override List<String> get variants {
  if (_variants is EqualUnmodifiableListView) return _variants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_variants);
}


/// Create a copy of TemplatePart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TemplatePartCopyWith<_TemplatePart> get copyWith => __$TemplatePartCopyWithImpl<_TemplatePart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TemplatePartToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TemplatePart'))
    ..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('variants', variants));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TemplatePart&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._variants, _variants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(_variants));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TemplatePart(type: $type, variants: $variants)';
}


}

/// @nodoc
abstract mixin class _$TemplatePartCopyWith<$Res> implements $TemplatePartCopyWith<$Res> {
  factory _$TemplatePartCopyWith(_TemplatePart value, $Res Function(_TemplatePart) _then) = __$TemplatePartCopyWithImpl;
@override @useResult
$Res call({
 String type, List<String> variants
});




}
/// @nodoc
class __$TemplatePartCopyWithImpl<$Res>
    implements _$TemplatePartCopyWith<$Res> {
  __$TemplatePartCopyWithImpl(this._self, this._then);

  final _TemplatePart _self;
  final $Res Function(_TemplatePart) _then;

/// Create a copy of TemplatePart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? variants = null,}) {
  return _then(_TemplatePart(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,variants: null == variants ? _self._variants : variants // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
