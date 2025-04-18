import "dart:async";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/sources/lessons/expression_parser.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/expression.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_state.dart";
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

    hslColor = context.read<HSLColor>();
    expressionParser = ExpressionParser();
    display = "0";
    appendOverrides = false;
  }

  @override
  Widget build(BuildContext context) {
    var neutralColor =
        hslColor
            .withSaturation((hslColor.saturation * 0.12).clamp(0, 1))
            .withLightness(0.3)
            .toColor();

    final accent = hslColor.withSaturation(hslColor.saturation * 0.5);
    final acKey = accent.withLightness((hslColor.lightness + 0.05).clamp(0, 1)).toColor();
    final equalsKey = accent.withLightness((hslColor.lightness - 0.1).clamp(0, 1)).toColor();

    return BlocListener<PracticePageBloc, PracticePageState>(
      listenWhen:
          (_, now) =>
              now.status == ChapterPageStatus.movingToNextQuestion ||
              now.status == ChapterPageStatus.evaluating,
      listener: (context, state) {
        if (state.status == ChapterPageStatus.evaluating) {
          _evaluate(submit: false);
        }
        if (state.status == ChapterPageStatus.movingToNextQuestion) {
          _clear();
        }
      },
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
                            onTap: () => _append(" ("),
                            label: "(",
                            color: neutralColor,
                          ),
                          _textButton(
                            onTap: () => _append(") "),
                            label: ")",
                            color: neutralColor,
                          ),
                        ],
                      ),
                    ),
                    _textButton(onTap: () => _append(" ^ "), label: "^", color: neutralColor),
                    _textButton(onTap: () => _append(" / "), label: "÷", color: neutralColor),
                  ],
                ),
                Row(
                  spacing: 4.0,
                  children: [
                    _textButton(onTap: () => _append("7"), label: "7", color: neutralColor),
                    _textButton(onTap: () => _append("8"), label: "8", color: neutralColor),
                    _textButton(onTap: () => _append("9"), label: "9", color: neutralColor),
                    _textButton(onTap: () => _append(" * "), label: "*", color: neutralColor),
                  ],
                ),
                Row(
                  spacing: 4.0,
                  children: [
                    _textButton(onTap: () => _append("4"), label: "4", color: neutralColor),
                    _textButton(onTap: () => _append("5"), label: "5", color: neutralColor),
                    _textButton(onTap: () => _append("6"), label: "6", color: neutralColor),
                    _textButton(onTap: () => _append(" - "), label: "-", color: neutralColor),
                  ],
                ),
                Row(
                  spacing: 4.0,
                  children: [
                    _textButton(onTap: () => _append("1"), label: "1", color: neutralColor),
                    _textButton(onTap: () => _append("2"), label: "2", color: neutralColor),
                    _textButton(onTap: () => _append("3"), label: "3", color: neutralColor),
                    _textButton(onTap: () => _append(" + "), label: "+", color: neutralColor),
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
                    _iconButton(onTap: _backspace, label: Icons.backspace, color: neutralColor),
                    _textButton(onTap: _evaluate, label: "=", color: equalsKey),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _append(String character, {bool replacesZero = true, bool submit = true}) {
    HapticFeedback.selectionClick();
    setState(() {
      if (appendOverrides || (display == "0" && replacesZero)) {
        display = character;

        appendOverrides = false;
      } else {
        display += character;
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
    setState(() {
      display = "ERR";
      appendOverrides = true;
    });
    HapticFeedback.heavyImpact();
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
      child: FilledButton.icon(
        style: FilledButton.styleFrom(padding: EdgeInsets.all(0), backgroundColor: color),
        onPressed: onTap,
        label: Text(label),
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
