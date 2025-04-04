// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Unit {
  String get id;
  String get shortcut;

  /// Create a copy of Unit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnitCopyWith<Unit> get copyWith =>
      _$UnitCopyWithImpl<Unit>(this as Unit, _$identity);

  /// Serializes this Unit to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Unit &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shortcut, shortcut) ||
                other.shortcut == shortcut));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, shortcut);

  @override
  String toString() {
    return 'Unit(id: $id, shortcut: $shortcut)';
  }
}

/// @nodoc
abstract mixin class $UnitCopyWith<$Res> {
  factory $UnitCopyWith(Unit value, $Res Function(Unit) _then) =
      _$UnitCopyWithImpl;
  @useResult
  $Res call({String id, String shortcut});
}

/// @nodoc
class _$UnitCopyWithImpl<$Res> implements $UnitCopyWith<$Res> {
  _$UnitCopyWithImpl(this._self, this._then);

  final Unit _self;
  final $Res Function(Unit) _then;

  /// Create a copy of Unit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shortcut = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      shortcut: null == shortcut
          ? _self.shortcut
          : shortcut // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Unit implements Unit {
  const _Unit({required this.id, required this.shortcut});
  factory _Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  @override
  final String id;
  @override
  final String shortcut;

  /// Create a copy of Unit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnitCopyWith<_Unit> get copyWith =>
      __$UnitCopyWithImpl<_Unit>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnitToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Unit &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shortcut, shortcut) ||
                other.shortcut == shortcut));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, shortcut);

  @override
  String toString() {
    return 'Unit(id: $id, shortcut: $shortcut)';
  }
}

/// @nodoc
abstract mixin class _$UnitCopyWith<$Res> implements $UnitCopyWith<$Res> {
  factory _$UnitCopyWith(_Unit value, $Res Function(_Unit) _then) =
      __$UnitCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String shortcut});
}

/// @nodoc
class __$UnitCopyWithImpl<$Res> implements _$UnitCopyWith<$Res> {
  __$UnitCopyWithImpl(this._self, this._then);

  final _Unit _self;
  final $Res Function(_Unit) _then;

  /// Create a copy of Unit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? shortcut = null,
  }) {
    return _then(_Unit(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      shortcut: null == shortcut
          ? _self.shortcut
          : shortcut // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
