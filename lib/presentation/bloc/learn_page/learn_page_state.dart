import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/data/models/unit.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/numerical_expression.dart";
import "package:scale_up/utils/extensions/to_string_as_fixed_max_extension.dart";

part "learn_page_state.freezed.dart";

enum LearnPageStatus {
  /// Page loading related status
  loading,
  waitingForSubmission,

  /// Answer related status.
  evaluating,
  correct,
  incorrect,

  /// Transition related status.
  movingAway,
  movingIn,

  /// Problem set related status.
  finished,
  leaving,

  /// Runtime error related status.
  error,
}

@freezed
sealed class LearnPageState with _$LearnPageState {
  const LearnPageState._();

  const factory LearnPageState.blank() = BlankLearnPageState;

  const factory LearnPageState.loading({
    required LearnPageStatus status,
    required Lesson? lesson,
    required int chapterIndex,
  }) = LoadingLearnPageState;

  const factory LearnPageState.error({required LearnPageStatus status, required String error}) =
      ErrorLearnPageState;

  const factory LearnPageState.loaded({
    required LearnPageStatus status,
    required int chapterIndex,
    required Lesson lesson,
    required List<LearnQuestion> questions,
    required int questionIndex,
    required double progress,
    required bool Function(Object?, Object?) comparison,
    required int mistakes,
    required DateTime startDateTime,
    Object? answer,
    Object? correctAnswer,
    String? error,
  }) = LoadedLearnPageState;
}

@freezed
sealed class LearnQuestion with _$LearnQuestion {
  const LearnQuestion._();

  const factory LearnQuestion.plain({
    required List<Widget> children,
    @Default(false) bool isRetry,
  }) = PlainLearnQuestion;

  const factory LearnQuestion.directFormula({
    required Unit from,
    required Unit to,
    required List<NumericalExpression> choices,
    required NumericalExpression answer,
    @Default(false) bool isRetry,
  }) = DirectFormulaLearnQuestion;

  const factory LearnQuestion.importantNumbers({
    required Unit from,
    required Unit to,
    required Set<Set<num>> choices,
    required Set<num> answer,
    @Default(false) bool isRetry,
  }) = ImportantNumbersLearnQuestion;

  const factory LearnQuestion.practiceConversion({
    required Unit from,
    required Unit to,
    required num question,
    required num answer,
    required List<((Unit, Unit), NumericalExpression)> path,
    @Default(false) bool isRetry,
  }) = PracticeConversionLearnQuestion;

  const factory LearnQuestion.indirectSteps({
    required Unit from,
    required Unit to,
    required List<((Unit, Unit), NumericalExpression)> steps,
    required List<Unit> choices,
    required List<Unit> answer,
    @Default(false) bool isRetry,
  }) = IndirectStepsLearnQuestion;

  String get correctAnswerString {
    return switch (this) {
      PlainLearnQuestion() => throw Error(),

      DirectFormulaLearnQuestion(:var from, :var to, answer: var o) => //
      "${to.shortcut} = ${o.substituteString("from", from.shortcut)}",

      ImportantNumbersLearnQuestion(answer: var o) => //
      (o.toList()..sort((a, b) => (a - b).toInt())).join(", "),

      IndirectStepsLearnQuestion(:var steps) => steps
          .map((p) => p.$1)
          .map((p) => "${p.$1.shortcut} to ${p.$2.shortcut}")
          .join(", "),

      PracticeConversionLearnQuestion(:var answer) => answer.toStringAsFixedMax(10),
    };
  }

  bool Function(Object?, Object?) get comparison {
    return switch (this) {
      PlainLearnQuestion() => (a, b) => true,

      DirectFormulaLearnQuestion() =>
        (a, b) => a is NumericalExpression && b is NumericalExpression && a.str == b.str,
      ImportantNumbersLearnQuestion() => //
        (a, b) =>
            a is Set<num> && b is Set<num> && a.difference(b).isEmpty && b.difference(a).isEmpty,

      IndirectStepsLearnQuestion() => (a, b) {
        if (a is! List<Unit> || b is! List<Unit> || a.length != b.length) {
          return false;
        }

        for (var i = 0; i < a.length; i++) {
          if (a[i].id != b[i].id) {
            return false;
          }
        }

        return true;
      },

      PracticeConversionLearnQuestion() =>
        (a, b) => a is num && b is num && a.toStringAsPrecision(4) == b.toStringAsPrecision(4),
    };
  }
}
