// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unit_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UnitGroup {
  String get type;
  List<Conversion> get conversions;
  List<Unit> get units;

  /// Create a copy of UnitGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnitGroupCopyWith<UnitGroup> get copyWith =>
      _$UnitGroupCopyWithImpl<UnitGroup>(this as UnitGroup, _$identity);

  /// Serializes this UnitGroup to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnitGroup &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other.conversions, conversions) &&
            const DeepCollectionEquality().equals(other.units, units));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      const DeepCollectionEquality().hash(conversions),
      const DeepCollectionEquality().hash(units));

  @override
  String toString() {
    return 'UnitGroup(type: $type, conversions: $conversions, units: $units)';
  }
}

/// @nodoc
abstract mixin class $UnitGroupCopyWith<$Res> {
  factory $UnitGroupCopyWith(UnitGroup value, $Res Function(UnitGroup) _then) =
      _$UnitGroupCopyWithImpl;
  @useResult
  $Res call({String type, List<Conversion> conversions, List<Unit> units});
}

/// @nodoc
class _$UnitGroupCopyWithImpl<$Res> implements $UnitGroupCopyWith<$Res> {
  _$UnitGroupCopyWithImpl(this._self, this._then);

  final UnitGroup _self;
  final $Res Function(UnitGroup) _then;

  /// Create a copy of UnitGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? conversions = null,
    Object? units = null,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      conversions: null == conversions
          ? _self.conversions
          : conversions // ignore: cast_nullable_to_non_nullable
              as List<Conversion>,
      units: null == units
          ? _self.units
          : units // ignore: cast_nullable_to_non_nullable
              as List<Unit>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UnitGroup extends UnitGroup {
  const _UnitGroup(
      {required this.type,
      required final List<Conversion> conversions,
      required final List<Unit> units})
      : _conversions = conversions,
        _units = units,
        super._();
  factory _UnitGroup.fromJson(Map<String, dynamic> json) =>
      _$UnitGroupFromJson(json);

  @override
  final String type;
  final List<Conversion> _conversions;
  @override
  List<Conversion> get conversions {
    if (_conversions is EqualUnmodifiableListView) return _conversions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversions);
  }

  final List<Unit> _units;
  @override
  List<Unit> get units {
    if (_units is EqualUnmodifiableListView) return _units;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_units);
  }

  /// Create a copy of UnitGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnitGroupCopyWith<_UnitGroup> get copyWith =>
      __$UnitGroupCopyWithImpl<_UnitGroup>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnitGroupToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnitGroup &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._conversions, _conversions) &&
            const DeepCollectionEquality().equals(other._units, _units));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      const DeepCollectionEquality().hash(_conversions),
      const DeepCollectionEquality().hash(_units));

  @override
  String toString() {
    return 'UnitGroup(type: $type, conversions: $conversions, units: $units)';
  }
}

/// @nodoc
abstract mixin class _$UnitGroupCopyWith<$Res>
    implements $UnitGroupCopyWith<$Res> {
  factory _$UnitGroupCopyWith(
          _UnitGroup value, $Res Function(_UnitGroup) _then) =
      __$UnitGroupCopyWithImpl;
  @override
  @useResult
  $Res call({String type, List<Conversion> conversions, List<Unit> units});
}

/// @nodoc
class __$UnitGroupCopyWithImpl<$Res> implements _$UnitGroupCopyWith<$Res> {
  __$UnitGroupCopyWithImpl(this._self, this._then);

  final _UnitGroup _self;
  final $Res Function(_UnitGroup) _then;

  /// Create a copy of UnitGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? conversions = null,
    Object? units = null,
  }) {
    return _then(_UnitGroup(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      conversions: null == conversions
          ? _self._conversions
          : conversions // ignore: cast_nullable_to_non_nullable
              as List<Conversion>,
      units: null == units
          ? _self._units
          : units // ignore: cast_nullable_to_non_nullable
              as List<Unit>,
    ));
  }
}

// dart format on
