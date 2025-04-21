import "dart:async";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/expression_parser.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/expression.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_state.dart";
import "package:scale_up/presentation/views/home/widgets/box_shadow.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/animation_controller_distinction.dart";
import "package:scale_up/utils/to_string_as_fixed_max_extension.dart";

/// A simple non-scientific calculator.
class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({required this.onEvaluate, super.key});

  final FutureOr<void> Function(Expression) onEvaluate;

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  late final HSLColor hslColor;
  late final ExpressionParser expressionParser;
  late String display;
  late bool appendOverrides;

  @override
  void initState() {
    super.initState();

    hslColor = context.read<PracticePageBloc>().loadedState.lesson.hslColor;
    expressionParser = ExpressionParser();
    display = "0";
    appendOverrides = false;
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor =
        hslColor.withSaturation(hslColor.saturation * 0.5).withLightness(0.95).toColor();
    var neutralColor =
        hslColor
            .withSaturation((hslColor.saturation * 0.12).clamp(0, 1))
            .withLightness(0.3)
            .toColor();

    var accent = hslColor.withSaturation(hslColor.saturation * 0.5);
    var acKey = accent.withLightness((hslColor.lightness + 0.05).clamp(0, 1)).toColor();
    var equalsKey = accent.withLightness((hslColor.lightness + 0.1).clamp(0, 1)).toColor();

    var widget = BlocListener<PracticePageBloc, PracticePageState>(
      listener: (context, state) {
        if (state.status == PracticePageStatus.evaluating) {
          _evaluate(submit: false);
        }
        if (state.status == PracticePageStatus.movingIn) {
          _clear();
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: defaultBoxShadow,
          ),
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              spacing: 8.0,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  readOnly: true,
                  controller: TextEditingController(text: display),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    disabledBorder: OutlineInputBorder(),
                  ),
                ),
                Column(
                  spacing: 4.0,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      spacing: 4.0,
                      children: [
                        _textButton(onTap: _clear, label: "AC", color: acKey),
                        Expanded(
                          child: Row(
                            spacing: 4.0,
                            children: [
                              _textButton(
                                onTap: () => _append("("),
                                label: "(",
                                color: neutralColor,
                              ),
                              _textButton(
                                onTap: () => _append(")"),
                                label: ")",
                                color: neutralColor,
                              ),
                            ],
                          ),
                        ),
                        _textButton(onTap: () => _append("^"), label: "^", color: neutralColor),
                        _textButton(onTap: () => _append("/"), label: "÷", color: neutralColor),
                      ],
                    ),
                    Row(
                      spacing: 4.0,
                      children: [
                        _textButton(onTap: () => _append("7"), label: "7", color: neutralColor),
                        _textButton(onTap: () => _append("8"), label: "8", color: neutralColor),
                        _textButton(onTap: () => _append("9"), label: "9", color: neutralColor),
                        _textButton(onTap: () => _append("*"), label: "*", color: neutralColor),
                      ],
                    ),
                    Row(
                      spacing: 4.0,
                      children: [
                        _textButton(onTap: () => _append("4"), label: "4", color: neutralColor),
                        _textButton(onTap: () => _append("5"), label: "5", color: neutralColor),
                        _textButton(onTap: () => _append("6"), label: "6", color: neutralColor),
                        _textButton(onTap: () => _append("-"), label: "-", color: neutralColor),
                      ],
                    ),
                    Row(
                      spacing: 4.0,
                      children: [
                        _textButton(onTap: () => _append("1"), label: "1", color: neutralColor),
                        _textButton(onTap: () => _append("2"), label: "2", color: neutralColor),
                        _textButton(onTap: () => _append("3"), label: "3", color: neutralColor),
                        _textButton(onTap: () => _append("+"), label: "+", color: neutralColor),
                      ],
                    ),
                    Row(
                      spacing: 4.0,
                      children: [
                        _textButton(onTap: () => _append("0"), label: "0", color: neutralColor),
                        _textButton(
                          onTap: () => _append(".", replacesZero: false),
                          label: ".",
                          color: neutralColor,
                        ),
                        _iconButton(
                          onTap: _backspace,
                          label: Icons.backspace,
                          color: neutralColor,
                        ),
                        _textButton(onTap: _evaluate, label: "=", color: equalsKey),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Styles.hint("Compute your answer here!", textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return widget
        .animate(
          controller: context.read<TransitionOutAnimationController>().controller,
          autoPlay: false,
        )
        .slideX(begin: 0.0, end: -0.5, curve: Curves.easeOutQuad)
        .fadeOut()
        .animate(
          controller: context.read<TransitionInAnimationController>().controller,
          autoPlay: false,
        )
        .slideX(begin: 0.5, end: 0.0, curve: Curves.easeOutQuad)
        .fadeIn();
  }

  void _append(String character, {bool replacesZero = true, bool submit = true}) {
    HapticFeedback.selectionClick();
    setState(() {
      if (appendOverrides || (display == "0" && replacesZero)) {
        display = character;

        if (appendOverrides) {
          appendOverrides = false;
        }
      } else {
        late var lastCharacter = display.trimRight().split("").last;
        var isLastCharacterDigit = display.isNotEmpty && lastCharacter.isDigitOrDot;
        var isCharacterDigitOrDot = character.isDigitOrDot;

        /// If the last character is a digit, and the current character is a digit,
        ///   then we should just append it plainly.
        if (isLastCharacterDigit && isCharacterDigitOrDot) {
          display = display.trimRight();
          display += character;
        }
        /// If the last character is NOT a digit (i.e. an operator),
        ///   Then we should append space.
        else if (!isLastCharacterDigit || !isCharacterDigitOrDot) {
          display = display.trimRight();
          display += " ";
          display += character;
        }
      }
    });

    /// Basically, we treat just typing a single number an evaluation.
    ///
    if (submit) {
      if (expressionParser.parse(display) case var expression?) {
        widget.onEvaluate(expression);
      }
    }
  }

  void _clear() {
    HapticFeedback.selectionClick();
    setState(() {
      display = "0";
    });
  }

  void _backspace() {
    HapticFeedback.selectionClick();

    if (display.trim().isEmpty) return;

    setState(() {
      if (appendOverrides) {
        display = "";
      } else {
        display = display.trimRight();
        display = display.substring(0, display.length - 1);
        display = display.trimRight();
      }

      if (display.isEmpty) {
        display = "0";
      }
    });
  }

  void _error() {
    HapticFeedback.heavyImpact();
    Future.delayed(const Duration(milliseconds: 500), () {
      HapticFeedback.heavyImpact();
    });
    setState(() {
      display = "ERR";
      appendOverrides = true;
    });
  }

  void _evaluate({bool submit = true}) {
    var expression = expressionParser.parse(display.trim());
    if (expression == null) {
      _error();
      return;
    }

    try {
      num value = expression.evaluate({});
      if (!value.isFinite) throw UnsupportedError("Values must be finite!");

      appendOverrides = true;
      _append(value.toStringAsFixedMax(3), submit: false);

      if (submit) {
        widget.onEvaluate(expression);
      }
    } on UnsupportedError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      _error();
      return;
    }
  }

  Widget _textButton({
    required void Function() onTap,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(64.0),
          boxShadow:defaultBoxShadow,
        ),
        child: FilledButton.icon(
          style: FilledButton.styleFrom(
            padding: EdgeInsets.all(0),
            backgroundColor: color,
            shadowColor: Colors.black,
          ),
          onPressed: onTap,
          label: Text(label),
        ),
      ),
    );
  }

  Widget _iconButton({
    required void Function() onTap,
    required IconData label,
    required Color color,
  }) {
    return Expanded(
      child: FilledButton.icon(
        style: FilledButton.styleFrom(padding: EdgeInsets.all(0), backgroundColor: color),
        onPressed: onTap,
        label: Icon(label),
      ),
    );
  }
}

extension on String {
  bool get isDigitOrDot {
    return int.tryParse(this) != null || this == ".";
  }
}
