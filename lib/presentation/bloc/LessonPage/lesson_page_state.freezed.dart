// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LessonPageState {
  Lesson get lesson;
  int? get chapterIndex;

  /// Create a copy of LessonPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LessonPageStateCopyWith<LessonPageState> get copyWith =>
      _$LessonPageStateCopyWithImpl<LessonPageState>(
          this as LessonPageState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LessonPageState &&
            (identical(other.lesson, lesson) || other.lesson == lesson) &&
            (identical(other.chapterIndex, chapterIndex) ||
                other.chapterIndex == chapterIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lesson, chapterIndex);

  @override
  String toString() {
    return 'LessonPageState(lesson: $lesson, chapterIndex: $chapterIndex)';
  }
}

/// @nodoc
abstract mixin class $LessonPageStateCopyWith<$Res> {
  factory $LessonPageStateCopyWith(
          LessonPageState value, $Res Function(LessonPageState) _then) =
      _$LessonPageStateCopyWithImpl;
  @useResult
  $Res call({Lesson lesson, int? chapterIndex});

  $LessonCopyWith<$Res> get lesson;
}

/// @nodoc
class _$LessonPageStateCopyWithImpl<$Res>
    implements $LessonPageStateCopyWith<$Res> {
  _$LessonPageStateCopyWithImpl(this._self, this._then);

  final LessonPageState _self;
  final $Res Function(LessonPageState) _then;

  /// Create a copy of LessonPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lesson = null,
    Object? chapterIndex = freezed,
  }) {
    return _then(_self.copyWith(
      lesson: null == lesson
          ? _self.lesson
          : lesson // ignore: cast_nullable_to_non_nullable
              as Lesson,
      chapterIndex: freezed == chapterIndex
          ? _self.chapterIndex
          : chapterIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of LessonPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LessonCopyWith<$Res> get lesson {
    return $LessonCopyWith<$Res>(_self.lesson, (value) {
      return _then(_self.copyWith(lesson: value));
    });
  }
}

/// @nodoc

class _LessonPageState extends LessonPageState {
  const _LessonPageState({required this.lesson, required this.chapterIndex})
      : super._();

  @override
  final Lesson lesson;
  @override
  final int? chapterIndex;

  /// Create a copy of LessonPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LessonPageStateCopyWith<_LessonPageState> get copyWith =>
      __$LessonPageStateCopyWithImpl<_LessonPageState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LessonPageState &&
            (identical(other.lesson, lesson) || other.lesson == lesson) &&
            (identical(other.chapterIndex, chapterIndex) ||
                other.chapterIndex == chapterIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lesson, chapterIndex);

  @override
  String toString() {
    return 'LessonPageState(lesson: $lesson, chapterIndex: $chapterIndex)';
  }
}

/// @nodoc
abstract mixin class _$LessonPageStateCopyWith<$Res>
    implements $LessonPageStateCopyWith<$Res> {
  factory _$LessonPageStateCopyWith(
          _LessonPageState value, $Res Function(_LessonPageState) _then) =
      __$LessonPageStateCopyWithImpl;
  @override
  @useResult
  $Res call({Lesson lesson, int? chapterIndex});

  @override
  $LessonCopyWith<$Res> get lesson;
}

/// @nodoc
class __$LessonPageStateCopyWithImpl<$Res>
    implements _$LessonPageStateCopyWith<$Res> {
  __$LessonPageStateCopyWithImpl(this._self, this._then);

  final _LessonPageState _self;
  final $Res Function(_LessonPageState) _then;

  /// Create a copy of LessonPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? lesson = null,
    Object? chapterIndex = freezed,
  }) {
    return _then(_LessonPageState(
      lesson: null == lesson
          ? _self.lesson
          : lesson // ignore: cast_nullable_to_non_nullable
              as Lesson,
      chapterIndex: freezed == chapterIndex
          ? _self.chapterIndex
          : chapterIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of LessonPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LessonCopyWith<$Res> get lesson {
    return $LessonCopyWith<$Res>(_self.lesson, (value) {
      return _then(_self.copyWith(lesson: value));
    });
  }
}

// dart format on
