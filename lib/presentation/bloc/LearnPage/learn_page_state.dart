import "package:freezed_annotation/freezed_annotation.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/numerical_expression.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/data/models/unit.dart";

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
    Object? answer,
    Object? correctAnswer,
    String? error,
  }) = LoadedLearnPageState;
}

@freezed
sealed class LearnQuestion with _$LearnQuestion {
  const LearnQuestion._();

  const factory LearnQuestion.directFormula({
    required Unit from,
    required Unit to,
    required List<NumericalExpression> choices,
    required NumericalExpression answer,
  }) = DirectFormulaLearnQuestion;

  const factory LearnQuestion.importantNumbers({
    required Unit from,
    required Unit to,
    required Set<Set<num>> choices,
    required Set<num> answer,
  }) = ImportantNumbersLearnQuestion;

  const factory LearnQuestion.indirectSteps({
    required Unit from,
    required Unit to,
    required List<((Unit, Unit), NumericalExpression)> steps,
    required List<Unit> choices,
    required List<Unit> answer,
  }) = IndirectStepsLearnQuestion;

  String get correctAnswerString {
    return switch (this) {
      DirectFormulaLearnQuestion(:var from, :var to, answer: var o) => //
      "${to.shortcut} = ${o.substituteString("from", from.shortcut)}",

      ImportantNumbersLearnQuestion(answer: var o) => //
      (o.toList()..sort((a, b) => (a - b).toInt())).join(", "),

      IndirectStepsLearnQuestion(:var steps) => steps
          .map((p) => p.$1)
          .map((p) => "${p.$1.shortcut} to ${p.$2.shortcut}")
          .join(", "),
    };
  }

  bool Function(Object?, Object?) get comparison {
    return switch (this) {
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
    };
  }
}
