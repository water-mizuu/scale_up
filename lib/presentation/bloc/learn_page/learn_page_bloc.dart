import "dart:async";
import "dart:math";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:markdown_widget/markdown_widget.dart";
import "package:scale_up/data/models/learn_chapter.dart";
import "package:scale_up/data/models/lesson.dart";
import "package:scale_up/data/models/unit.dart";
import "package:scale_up/data/models/unit_group.dart";
import "package:scale_up/data/sources/lessons/lessons_helper.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/numerical_expression.dart";
import "package:scale_up/presentation/bloc/learn_page/learn_page_event.dart";
import "package:scale_up/presentation/bloc/learn_page/learn_page_state.dart";
import "package:scale_up/utils/extensions/choose_random_extension.dart";
import "package:scale_up/utils/extensions/hsl_color_scheme_extension.dart";
import "package:scale_up/utils/extensions/unindent_extension.dart";
import "package:scale_up/utils/markdown_latex.dart";
import "package:scale_up/utils/sound_player.dart";

export "learn_page_event.dart";
export "learn_page_state.dart";

class LearnPageBloc extends Bloc<LearnPageEvent, LearnPageState> {
  LearnPageBloc({required LessonsHelper lessonsHelper})
    : _lessonsHelper = lessonsHelper,
      super(const LearnPageState.blank()) {
    on<LearnPageWidgetChanged>(_onLearnPageWidgetChanged);
    on<LearnPageAnswerUpdated>(_onAnswerUpdated);
    on<LearnPageAnswerSubmitted>(_onAnswerSubmitted);
    on<LearnPageNextQuestionClicked>(_onNextQuestionClicked);
    on<LearnPageReturnToLessonClicked>(_onReturnToLessonClicked);

    on<LearnPageMovingAwayComplete>(_onMovingAwayComplete);
    on<LearnPageMovingInComplete>(_onMovingInComplete);
  }

  final LessonsHelper _lessonsHelper;

  @pragma("vm:prefer-inline")
  LoadedLearnPageState get loadedState => state as LoadedLearnPageState;

  @override
  void onEvent(LearnPageEvent event) {
    super.onEvent(event);

    if (kDebugMode) {
      print("[LEARN_PAGE_BLOC] $event");
    }
  }

  /// This generates questions for the given learn chapter.
  List<LearnQuestion> _generateQuestions(Lesson lesson, LearnChapter learnChapter) {
    var questions = <LearnQuestion>[];
    var directQuestions = <LearnQuestion>[];
    var indirectQuestions = <LearnQuestion>[];

    /// The local unit group gets the conversions for the units in the specific units.
    /// The extended unit group gets additionally the inverse conversions.
    var unitGroup = _lessonsHelper.getLocalUnitGroup(lesson.unitsType, learnChapter.units);
    var extendedUnitGroup = _lessonsHelper.getLocalExtendedUnitGroup(
      lesson.unitsType,
      learnChapter.units,
    );

    if (unitGroup == null || extendedUnitGroup == null) {
      throw Exception("Unit group not found");
    }

    var hasEncouragedIndirect = false;
    var seen = <(Unit, Unit)>{};

    /// O(n^2) scan through all units in the learn chapter.
    for (var from in learnChapter.units) {
      for (var to in learnChapter.units) {
        if (from == to) continue;

        var fromUnit = _lessonsHelper.getUnit(lesson.unitsType, from);
        var toUnit = _lessonsHelper.getUnit(lesson.unitsType, to);

        if (fromUnit == null || toUnit == null) {
          throw Exception("Unit not found");
        }

        var conversion = _lessonsHelper.getConversionPathFor(fromUnit, toUnit);
        if (conversion == null) {
          if (kDebugMode) {
            print("Conversion not found for $fromUnit to $toUnit");
          }

          /// If this happens, then we need to update the lessons.yaml properly.
          throw Exception("Conversion not found");
        }

        var isDirect = conversion.length == 1;
        var isInverse = seen.contains((toUnit, fromUnit));
        var generated = _generateQuestionsForConversion(
          lesson,
          conversion,
          unitGroup,
          extendedUnitGroup,
          isInverse: isInverse,
          isUserEncouraged: !isDirect && hasEncouragedIndirect,
        );

        seen.add((fromUnit, toUnit));
        if (isDirect) {
          directQuestions.addAll(generated);
        } else {
          indirectQuestions.addAll(generated);
          hasEncouragedIndirect = true;
        }
      }
    }

    questions
      ..addAll(directQuestions)
      ..addAll(indirectQuestions);

    return questions;
  }

  void _onLearnPageWidgetChanged(
    LearnPageWidgetChanged event,
    Emitter<LearnPageState> emit,
  ) async {
    try {
      var lesson = event.lesson;

      if (lesson == null) {
        throw Exception("Lesson not found");
      }

      var questions = _generateQuestions(lesson, lesson.learnChapters[event.chapterIndex]);

      emit(
        LearnPageState.loaded(
          status: LearnPageStatus.movingIn,
          lesson: lesson,
          chapterIndex: event.chapterIndex,
          questions: questions,
          comparison: questions.first.comparison,
          questionIndex: 0,
          progress: 0.0,
          mistakes: 0,
          startDateTime: DateTime.now(),
        ),
      );
    } on Exception catch (e) {
      emit(LearnPageState.error(status: LearnPageStatus.error, error: e.toString()));
    }
  }

  void _onAnswerSubmitted(LearnPageAnswerSubmitted event, Emitter<LearnPageState> emit) async {
    assert(state is LoadedLearnPageState, "State should be loaded.");
    emit(loadedState.copyWith(status: LearnPageStatus.evaluating));
    await Future.delayed(Duration.zero);

    var question = loadedState.questions[loadedState.questionIndex];
    switch (question) {
      case PlainLearnQuestion():
        emit(loadedState.copyWith(status: LearnPageStatus.correct));
        return;
      case DirectFormulaLearnQuestion(answer: Object correctAnswer):
      case ImportantNumbersLearnQuestion(answer: Object correctAnswer):
      case IndirectStepsLearnQuestion(answer: Object correctAnswer):
      case PracticeConversionLearnQuestion(answer: Object correctAnswer):
        var answer = loadedState.answer;

        if (question.comparison(answer, correctAnswer)) {
          playCorrect();

          emit(
            loadedState.copyWith(status: LearnPageStatus.correct, correctAnswer: correctAnswer),
          );
        } else {
          playIncorrect();

          var questions = loadedState.questions;
          var removed = questions[loadedState.questionIndex].copyWith(isRetry: true);
          var newQuestions = questions.followedBy([removed]).toList();

          /// PROBLEM:
          ///   When the user answers incorrectly, since we update the [questions],
          ///   The [questionIndex] is not updated.
          emit(
            loadedState.copyWith(
              status: LearnPageStatus.incorrect,
              correctAnswer: correctAnswer,
              questions: newQuestions,
              mistakes: loadedState.mistakes + 1,
            ),
          );
        }
    }
  }

  void _onAnswerUpdated(LearnPageAnswerUpdated event, Emitter<LearnPageState> emit) async {
    assert(state is LoadedLearnPageState);

    emit(loadedState.copyWith(answer: event.answer));
  }

  void _onNextQuestionClicked(
    LearnPageNextQuestionClicked event,
    Emitter<LearnPageState> emit,
  ) async {
    emit(loadedState.copyWith(status: LearnPageStatus.movingAway));
  }

  void _onMovingAwayComplete(
    LearnPageMovingAwayComplete event,
    Emitter<LearnPageState> emit,
  ) async {
    var newQuestionIndex = loadedState.questionIndex + 1;
    late var mistakes = loadedState.mistakes;

    if (newQuestionIndex >= loadedState.questions.length) {
      emit(loadedState.copyWith(status: LearnPageStatus.finished, progress: 1.0));
      return;
    }

    emit(
      loadedState.copyWith(
        status: LearnPageStatus.movingIn,
        questionIndex: newQuestionIndex,
        progress: (newQuestionIndex - mistakes) / (loadedState.questions.length - mistakes),
        answer: null,
      ),
    );
  }

  void _onMovingInComplete(LearnPageMovingInComplete event, Emitter<LearnPageState> emit) async {
    emit(loadedState.copyWith(status: LearnPageStatus.waitingForSubmission));
  }

  void _onReturnToLessonClicked(
    LearnPageReturnToLessonClicked event,
    Emitter<LearnPageState> emit,
  ) async {
    emit(loadedState.copyWith(status: LearnPageStatus.leaving));
  }

  List<LearnQuestion> _generateQuestionsForConversion(
    Lesson lesson,
    List<((Unit, Unit), NumericalExpression)> path,
    UnitGroup unitGroup,
    UnitGroup extendedUnitGroup, {
    required bool isInverse,
    bool isUserEncouraged = false,
  }) {
    var isDirect = path.length == 1;
    var questions = <LearnQuestion>[];
    var ((from, _), _) = path.first;
    var ((_, to), _) = path.last;

    if (isDirect) {
      var (_, expression) = path.single;
      var quizQuestions = <LearnQuestion>[];
      var isInverse =
          extendedUnitGroup.conversions.any((c) => c.from == from.id && c.to == to.id) &&
          !(unitGroup.conversions.any((c) => c.from == from.id && c.to == to.id));

      /// This block is responsible for generating
      ///    the descriptive (plain) questions.
      do {
        var templates = _lessonsHelper.getTemplate("direct");
        if (templates == null) {
          throw Exception("Template not found for 'direct'.");
        }

        var leftConversion = NumericalExpression.toLeftEnglish(expression);
        var lhs = to.shortcut;
        var rhs = expression.substituteString("from", from.shortcut).toString();

        var fromBase = from.display ?? from.name;
        var toBase = to.display ?? to.name;

        var generated = templates.generateRandom({
          "from_full": "$fromBase (${from.shortcut})",
          "to_full": "$toBase (${to.shortcut})",
          "from": fromBase,
          "to": toBase,
          "left_conversion_english": leftConversion ?? "",
          "number": expression.constants.map((c) => c.value).toSet().join(", "),
          "equation": "$lhs = $rhs",
        });

        var children = <Widget>[
          if (leftConversion != null) ...[
            _markdown(generated["main_sentence"]!),
            _markdown(generated["equation_display"]!),
          ] else
            _markdown(generated["main_sentence_no_conversion"]!),

          if (isInverse)
            _markdown(generated["inverse"]!)
          else
            _markdown(generated["important_number"]!),
        ];

        questions.add(LearnQuestion.plain(children: children));
      } while (false);

      /// This block is responsible for generating
      ///  "What are the important numbers for converting from X to Y?"
      do {
        if (isInverse) break;

        var constants = expression.constants.toSet();
        var correctAnswer = constants.map((c) => c.value).toSet();
        var choices = {correctAnswer};

        for (var i = 0; i < 3; ++i) {
          Set<num> mutatedAnswer;

          do {
            mutatedAnswer =
                (constants.take(correctAnswer.length))
                    .map((c) => c.mutate())
                    .whereType<ConstantExpression>()
                    .map((c) => c.value)
                    .toSet();
          } while (choices.any((c) {
            return c.difference(mutatedAnswer).isEmpty && mutatedAnswer.difference(c).isEmpty;
          }));

          choices.add(mutatedAnswer);
        }

        quizQuestions.add(
          LearnQuestion.importantNumbers(
            from: from,
            to: to,
            choices: choices,
            answer: correctAnswer,
          ),
        );
      } while (false);

      /// This block is responsible for generating
      ///   "What is the formula for converting from X to Y?"
      ///   questions.
      do {
        var choices = [expression];
        for (var i = 0; i < 3; ++i) {
          NumericalExpression mutated;

          /// There is a probability that the mutated expression is unchanged.
          ///   So, we just keep mutating until we get a different one.
          do {
            mutated = expression.mutate();
          } while (choices.any((c) => c.str == mutated.str));

          choices.add(mutated);
        }
        choices.shuffle();
        assert(choices.contains(expression));

        /// To make choices, we have to "mutate" the answer.
        quizQuestions.add(
          LearnQuestion.directFormula(
            from: from, //
            to: to,
            choices: choices,
            answer: expression,
          ),
        );
      } while (false);

      quizQuestions.shuffle();
      questions.addAll(quizQuestions);
    } else {
      /// This block is responsible for generating
      ///    the descriptive (plain) questions.
      do {
        if (isInverse) break;

        var templates = _lessonsHelper.getTemplate("indirect");
        if (templates == null) {
          throw Exception("Template not found for 'indirect'.");
        }
        var pathBuffer = [
          for (var ((from, to), _) in path)
            "**${from.name} (${from.shortcut})** to **${to.name} (${to.shortcut})**",
        ];
        var pathString = pathBuffer.join(", then ");

        var fromBase = from.display ?? from.name;
        var toBase = to.display ?? to.name;

        var generated = templates.generateRandom({
          "from_full": "$fromBase (${from.shortcut})",
          "to_full": "$toBase (${to.shortcut})",
          "path": pathString,
        });

        var children = <Widget>[
          _markdown(generated["overview_path"]!),
          // conversion_box
          _conversionPathBox(lesson.color, path),
          _markdown("---"),
          if (!isUserEncouraged) _markdown(generated["benefit_vs_memory"]!),
          Column(
            spacing: 8.0,
            children: [
              for (var (index, step) in path.indexed)
                _conversionStepBox(index, lesson.color, step),
              _combinedFormulaBox(lesson.color, path),
            ],
          ),

          if (!isUserEncouraged) ...[
            _markdown(generated["when_to_use_indirect"]!),
            _markdown(generated["summary_encouragement"]!),
          ],
        ];

        questions.add(LearnQuestion.plain(children: children));
      } while (false);

      /// This block is responsible for generating
      ///   What are the path steps for converting from X to Y?
      do {
        var steps = path;

        /// We take the units from each path,
        var answer = steps.expand((s) => [s.$1.$1, s.$1.$2]).toList();

        /// Remove the first and last units. (They are the from and to units.)
        answer = answer.sublist(1, answer.length - 1);

        /// We need to generate incorrect answers, so we need
        ///   to remove the answer from the list of all units.
        var remainingOptions = unitGroup.units.where((u) => !answer.contains(u)).toList();

        /// Then, we generate incorrect answers with the same length
        ///   as the answer.
        var incorrect = answer.map((_) => remainingOptions.chooseRandom());

        /// Then, the total choices are the answer followed by the incorrect ones.
        ///   We need to shuffle them.
        var choices = answer.followedBy(incorrect).toList()..shuffle();

        questions.add(
          LearnQuestion.indirectSteps(
            from: from,
            to: to,
            steps: steps,
            choices: choices,
            answer: answer,
          ),
        );
      } while (false);
    }

    /// This block is responsible for generating
    ///   "Try it yourself" questions.
    do {
      var questionValue = Random().nextInt(80) + 20;
      var answer = path.map((p) => p.$2).toList().evaluate(questionValue);

      questions.add(
        LearnQuestion.practiceConversion(
          from: from,
          to: to,
          question: questionValue,
          answer: answer,
          path: path,
        ),
      );
    } while (false);

    return questions;
  }
}

Widget _combinedFormulaBox(Color originalColor, List<((Unit, Unit), NumericalExpression)> path) {
  var ((from, _), expression) = path.first;
  var ((_, to), _) = path.last;
  for (var (_, expr) in path.skip(1)) {
    expression = expr.substitute("from", expression);
  }

  var lhs = to.shortcut;
  var rhs = expression.substituteString("from", from.shortcut);
  var formula = "$lhs = $rhs";

  var data = """
    **Combined Formula**
    Formula: \$$formula\$
    """;
  data = data.unindent();

  var originalHslColor = HSLColor.fromColor(originalColor);
  var hslColor =
      originalHslColor //
          .withHue((originalHslColor.hue + ((path.length + 1) * 30)) % 360)
          .toColor();

  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: hslColor.backgroundColor,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: _markdown(data, height: 1.5),
  );
}

Widget _conversionStepBox(
  int index,
  Color originalColor,
  ((Unit, Unit), NumericalExpression) step,
) {
  var ((from, to), expression) = step;

  var lhs = to.shortcut;
  var rhs = expression.substituteString("from", from.shortcut);
  var formula = "$lhs = $rhs";

  var data = """
    **Step ${index + 1}: ${from.name} to ${to.name}**
    Formula: \$$formula\$
    """;
  data = data.unindent();

  var originalHslColor = HSLColor.fromColor(originalColor);
  var hslColor =
      originalHslColor //
          .withHue((originalHslColor.hue + ((index + 1) * 30)) % 360)
          .toColor();

  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: hslColor.backgroundColor,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: _markdown(data, height: 1.5),
  );
}

Widget _conversionPathBox(Color color, List<((Unit, Unit), NumericalExpression)> path) {
  var stringPath = path.map((p) => p.$1.$1.name).followedBy([path.last.$1.$2.name]).join(" → ");
  var data = "**Conversion Path:** $stringPath";

  var hslColor = HSLColor.fromColor(color);
  var backgroundHslColor = HSLColor.fromColor(hslColor.backgroundColor);

  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: hslColor.backgroundColor,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: backgroundHslColor.withLightness(backgroundHslColor.lightness * 0.9).toColor(),
            borderRadius: BorderRadius.circular(64.0),
          ),
          child: Icon(Icons.arrow_forward, color: color),
        ),
        const SizedBox(width: 12.0),
        Expanded(child: _markdown(data, height: 1.2)),
      ],
    ),
  );
}

Widget _markdown(String data, {double? height}) {
  return MarkdownWidget(
    data: data,
    shrinkWrap: true,
    selectable: false,
    config: MarkdownConfig.defaultConfig.copy(
      configs: [
        PConfig(textStyle: TextStyle(fontSize: 14.0, color: Colors.black, height: height ?? 2.0)),
      ],
    ),
    markdownGenerator: MarkdownGenerator(
      generators: [latexGenerator],
      inlineSyntaxList: [LatexSyntax()],
    ),
  );
}
