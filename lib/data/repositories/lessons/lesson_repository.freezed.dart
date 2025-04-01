// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UnitGroup implements DiagnosticableTreeMixin {
  String get name;
  List<Conversion> get conversions;
  List<String> get units;

  /// Create a copy of UnitGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnitGroupCopyWith<UnitGroup> get copyWith =>
      _$UnitGroupCopyWithImpl<UnitGroup>(this as UnitGroup, _$identity);

  /// Serializes this UnitGroup to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'UnitGroup'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('conversions', conversions))
      ..add(DiagnosticsProperty('units', units));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnitGroup &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other.conversions, conversions) &&
            const DeepCollectionEquality().equals(other.units, units));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(conversions),
      const DeepCollectionEquality().hash(units));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UnitGroup(name: $name, conversions: $conversions, units: $units)';
  }
}

/// @nodoc
abstract mixin class $UnitGroupCopyWith<$Res> {
  factory $UnitGroupCopyWith(UnitGroup value, $Res Function(UnitGroup) _then) =
      _$UnitGroupCopyWithImpl;
  @useResult
  $Res call({String name, List<Conversion> conversions, List<String> units});
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
    Object? name = null,
    Object? conversions = null,
    Object? units = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      conversions: null == conversions
          ? _self.conversions
          : conversions // ignore: cast_nullable_to_non_nullable
              as List<Conversion>,
      units: null == units
          ? _self.units
          : units // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UnitGroup with DiagnosticableTreeMixin implements UnitGroup {
  const _UnitGroup(
      {required this.name,
      required final List<Conversion> conversions,
      required final List<String> units})
      : _conversions = conversions,
        _units = units;
  factory _UnitGroup.fromJson(Map<String, dynamic> json) =>
      _$UnitGroupFromJson(json);

  @override
  final String name;
  final List<Conversion> _conversions;
  @override
  List<Conversion> get conversions {
    if (_conversions is EqualUnmodifiableListView) return _conversions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversions);
  }

  final List<String> _units;
  @override
  List<String> get units {
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
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'UnitGroup'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('conversions', conversions))
      ..add(DiagnosticsProperty('units', units));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnitGroup &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._conversions, _conversions) &&
            const DeepCollectionEquality().equals(other._units, _units));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(_conversions),
      const DeepCollectionEquality().hash(_units));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UnitGroup(name: $name, conversions: $conversions, units: $units)';
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
  $Res call({String name, List<Conversion> conversions, List<String> units});
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
    Object? name = null,
    Object? conversions = null,
    Object? units = null,
  }) {
    return _then(_UnitGroup(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      conversions: null == conversions
          ? _self._conversions
          : conversions // ignore: cast_nullable_to_non_nullable
              as List<Conversion>,
      units: null == units
          ? _self._units
          : units // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
mixin _$Conversion implements DiagnosticableTreeMixin {
  String get from;
  String get to;
  Expression get formula;

  /// Create a copy of Conversion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConversionCopyWith<Conversion> get copyWith =>
      _$ConversionCopyWithImpl<Conversion>(this as Conversion, _$identity);

  /// Serializes this Conversion to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'Conversion'))
      ..add(DiagnosticsProperty('from', from))
      ..add(DiagnosticsProperty('to', to))
      ..add(DiagnosticsProperty('formula', formula));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Conversion &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.formula, formula) || other.formula == formula));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, from, to, formula);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Conversion(from: $from, to: $to, formula: $formula)';
  }
}

/// @nodoc
abstract mixin class $ConversionCopyWith<$Res> {
  factory $ConversionCopyWith(
          Conversion value, $Res Function(Conversion) _then) =
      _$ConversionCopyWithImpl;
  @useResult
  $Res call({String from, String to, Expression formula});
}

/// @nodoc
class _$ConversionCopyWithImpl<$Res> implements $ConversionCopyWith<$Res> {
  _$ConversionCopyWithImpl(this._self, this._then);

  final Conversion _self;
  final $Res Function(Conversion) _then;

  /// Create a copy of Conversion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to = null,
    Object? formula = null,
  }) {
    return _then(_self.copyWith(
      from: null == from
          ? _self.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _self.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      formula: null == formula
          ? _self.formula
          : formula // ignore: cast_nullable_to_non_nullable
              as Expression,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Conversion with DiagnosticableTreeMixin implements Conversion {
  const _Conversion(
      {required this.from, required this.to, required this.formula});
  factory _Conversion.fromJson(Map<String, dynamic> json) =>
      _$ConversionFromJson(json);

  @override
  final String from;
  @override
  final String to;
  @override
  final Expression formula;

  /// Create a copy of Conversion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConversionCopyWith<_Conversion> get copyWith =>
      __$ConversionCopyWithImpl<_Conversion>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConversionToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'Conversion'))
      ..add(DiagnosticsProperty('from', from))
      ..add(DiagnosticsProperty('to', to))
      ..add(DiagnosticsProperty('formula', formula));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Conversion &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.formula, formula) || other.formula == formula));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, from, to, formula);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Conversion(from: $from, to: $to, formula: $formula)';
  }
}

/// @nodoc
abstract mixin class _$ConversionCopyWith<$Res>
    implements $ConversionCopyWith<$Res> {
  factory _$ConversionCopyWith(
          _Conversion value, $Res Function(_Conversion) _then) =
      __$ConversionCopyWithImpl;
  @override
  @useResult
  $Res call({String from, String to, Expression formula});
}

/// @nodoc
class __$ConversionCopyWithImpl<$Res> implements _$ConversionCopyWith<$Res> {
  __$ConversionCopyWithImpl(this._self, this._then);

  final _Conversion _self;
  final $Res Function(_Conversion) _then;

  /// Create a copy of Conversion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? from = null,
    Object? to = null,
    Object? formula = null,
  }) {
    return _then(_Conversion(
      from: null == from
          ? _self.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _self.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      formula: null == formula
          ? _self.formula
          : formula // ignore: cast_nullable_to_non_nullable
              as Expression,
    ));
  }
}

/// @nodoc
mixin _$Lesson implements DiagnosticableTreeMixin {
  String get category;
  String get name;
  String get description;
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  Color get color;
  List<String> get units;
  List<Chapter> get chapters;

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LessonCopyWith<Lesson> get copyWith =>
      _$LessonCopyWithImpl<Lesson>(this as Lesson, _$identity);

  /// Serializes this Lesson to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'Lesson'))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('units', units))
      ..add(DiagnosticsProperty('chapters', chapters));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Lesson &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.color, color) || other.color == color) &&
            const DeepCollectionEquality().equals(other.units, units) &&
            const DeepCollectionEquality().equals(other.chapters, chapters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      category,
      name,
      description,
      color,
      const DeepCollectionEquality().hash(units),
      const DeepCollectionEquality().hash(chapters));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Lesson(category: $category, name: $name, description: $description, color: $color, units: $units, chapters: $chapters)';
  }
}

/// @nodoc
abstract mixin class $LessonCopyWith<$Res> {
  factory $LessonCopyWith(Lesson value, $Res Function(Lesson) _then) =
      _$LessonCopyWithImpl;
  @useResult
  $Res call(
      {String category,
      String name,
      String description,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson) Color color,
      List<String> units,
      List<Chapter> chapters});
}

/// @nodoc
class _$LessonCopyWithImpl<$Res> implements $LessonCopyWith<$Res> {
  _$LessonCopyWithImpl(this._self, this._then);

  final Lesson _self;
  final $Res Function(Lesson) _then;

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? name = null,
    Object? description = null,
    Object? color = null,
    Object? units = null,
    Object? chapters = null,
  }) {
    return _then(_self.copyWith(
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      units: null == units
          ? _self.units
          : units // ignore: cast_nullable_to_non_nullable
              as List<String>,
      chapters: null == chapters
          ? _self.chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<Chapter>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Lesson with DiagnosticableTreeMixin implements Lesson {
  const _Lesson(
      {required this.category,
      required this.name,
      required this.description,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
      required this.color,
      required final List<String> units,
      required final List<Chapter> chapters})
      : _units = units,
        _chapters = chapters;
  factory _Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

  @override
  final String category;
  @override
  final String name;
  @override
  final String description;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  final Color color;
  final List<String> _units;
  @override
  List<String> get units {
    if (_units is EqualUnmodifiableListView) return _units;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_units);
  }

  final List<Chapter> _chapters;
  @override
  List<Chapter> get chapters {
    if (_chapters is EqualUnmodifiableListView) return _chapters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chapters);
  }

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LessonCopyWith<_Lesson> get copyWith =>
      __$LessonCopyWithImpl<_Lesson>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LessonToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'Lesson'))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('units', units))
      ..add(DiagnosticsProperty('chapters', chapters));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Lesson &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.color, color) || other.color == color) &&
            const DeepCollectionEquality().equals(other._units, _units) &&
            const DeepCollectionEquality().equals(other._chapters, _chapters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      category,
      name,
      description,
      color,
      const DeepCollectionEquality().hash(_units),
      const DeepCollectionEquality().hash(_chapters));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Lesson(category: $category, name: $name, description: $description, color: $color, units: $units, chapters: $chapters)';
  }
}

/// @nodoc
abstract mixin class _$LessonCopyWith<$Res> implements $LessonCopyWith<$Res> {
  factory _$LessonCopyWith(_Lesson value, $Res Function(_Lesson) _then) =
      __$LessonCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String category,
      String name,
      String description,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson) Color color,
      List<String> units,
      List<Chapter> chapters});
}

/// @nodoc
class __$LessonCopyWithImpl<$Res> implements _$LessonCopyWith<$Res> {
  __$LessonCopyWithImpl(this._self, this._then);

  final _Lesson _self;
  final $Res Function(_Lesson) _then;

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? category = null,
    Object? name = null,
    Object? description = null,
    Object? color = null,
    Object? units = null,
    Object? chapters = null,
  }) {
    return _then(_Lesson(
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      units: null == units
          ? _self._units
          : units // ignore: cast_nullable_to_non_nullable
              as List<String>,
      chapters: null == chapters
          ? _self._chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<Chapter>,
    ));
  }
}

/// @nodoc
mixin _$Chapter implements DiagnosticableTreeMixin {
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
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'Chapter'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('questionCount', questionCount))
      ..add(DiagnosticsProperty('units', units));
  }

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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
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
class _Chapter with DiagnosticableTreeMixin implements Chapter {
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
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'Chapter'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('questionCount', questionCount))
      ..add(DiagnosticsProperty('units', units));
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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
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
