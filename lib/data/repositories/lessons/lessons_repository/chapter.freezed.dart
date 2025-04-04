// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Chapter {
  String get name;
  @JsonKey(name: "question_count")
  int get questionCount;
  List<String> get units;

  /// Create a copy of Chapter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChapterCopyWith<Chapter> get copyWith =>
      _$ChapterCopyWithImpl<Chapter>(this as Chapter, _$identity);

  /// Serializes this Chapter to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Chapter &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.questionCount, questionCount) ||
                other.questionCount == questionCount) &&
            const DeepCollectionEquality().equals(other.units, units));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, questionCount,
      const DeepCollectionEquality().hash(units));

  @override
  String toString() {
    return 'Chapter(name: $name, questionCount: $questionCount, units: $units)';
  }
}

/// @nodoc
abstract mixin class $ChapterCopyWith<$Res> {
  factory $ChapterCopyWith(Chapter value, $Res Function(Chapter) _then) =
      _$ChapterCopyWithImpl;
  @useResult
  $Res call(
      {String name,
      @JsonKey(name: "question_count") int questionCount,
      List<String> units});
}

/// @nodoc
class _$ChapterCopyWithImpl<$Res> implements $ChapterCopyWith<$Res> {
  _$ChapterCopyWithImpl(this._self, this._then);

  final Chapter _self;
  final $Res Function(Chapter) _then;

  /// Create a copy of Chapter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? questionCount = null,
    Object? units = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      questionCount: null == questionCount
          ? _self.questionCount
          : questionCount // ignore: cast_nullable_to_non_nullable
              as int,
      units: null == units
          ? _self.units
          : units // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Chapter implements Chapter {
  const _Chapter(
      {required this.name,
      @JsonKey(name: "question_count") required this.questionCount,
      required final List<String> units})
      : _units = units;
  factory _Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: "question_count")
  final int questionCount;
  final List<String> _units;
  @override
  List<String> get units {
    if (_units is EqualUnmodifiableListView) return _units;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_units);
  }

  /// Create a copy of Chapter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChapterCopyWith<_Chapter> get copyWith =>
      __$ChapterCopyWithImpl<_Chapter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChapterToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Chapter &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.questionCount, questionCount) ||
                other.questionCount == questionCount) &&
            const DeepCollectionEquality().equals(other._units, _units));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, questionCount,
      const DeepCollectionEquality().hash(_units));

  @override
  String toString() {
    return 'Chapter(name: $name, questionCount: $questionCount, units: $units)';
  }
}

/// @nodoc
abstract mixin class _$ChapterCopyWith<$Res> implements $ChapterCopyWith<$Res> {
  factory _$ChapterCopyWith(_Chapter value, $Res Function(_Chapter) _then) =
      __$ChapterCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String name,
      @JsonKey(name: "question_count") int questionCount,
      List<String> units});
}

/// @nodoc
class __$ChapterCopyWithImpl<$Res> implements _$ChapterCopyWith<$Res> {
  __$ChapterCopyWithImpl(this._self, this._then);

  final _Chapter _self;
  final $Res Function(_Chapter) _then;

  /// Create a copy of Chapter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? questionCount = null,
    Object? units = null,
  }) {
    return _then(_Chapter(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      questionCount: null == questionCount
          ? _self.questionCount
          : questionCount // ignore: cast_nullable_to_non_nullable
              as int,
      units: null == units
          ? _self._units
          : units // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
