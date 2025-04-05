import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/data/repositories/lessons/expression_parser.dart";
import "package:scale_up/data/repositories/lessons/lessons_repository/expression.dart";
import "package:scale_up/presentation/bloc/ChapterPageBloc/chapter_page_bloc.dart";
import "package:scale_up/presentation/bloc/ChapterPageBloc/chapter_page_state.dart";

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({required this.onEvaluate, super.key});

  final FutureOr<void> Function(num) onEvaluate;

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  late final ExpressionParser expressionParser;
  late String display;
  late bool appendOverrides;

  @override
  void initState() {
    super.initState();

    expressionParser = ExpressionParser();
    display = "0";
    appendOverrides = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChapterPageBloc, ChapterPageState>(
      listenWhen: (_, now) => now.status == ChapterPageStatus.nextQuestion,
      listener: (context, state) {
        if (state.status == ChapterPageStatus.nextQuestion) {
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
              enabled: false,
              controller: TextEditingController(text: display),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                disabledBorder: OutlineInputBorder(),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  spacing: 4.0,
                  children: [
                    _textButton(
                      onTap: _clear,
                      label: "AC",
                      color: const Color.fromARGB(255, 151, 91, 91),
                    ),
                    Expanded(
                      child: Row(
                        spacing: 4.0,
                        children: [
                          _textButton(
                            onTap: () => _append(" ("),
                            label: "(",
                            color: Colors.blueGrey,
                          ),
                          _textButton(
                            onTap: () => _append(") "),
                            label: ")",
                            color: Colors.blueGrey,
                          ),
                        ],
                      ),
                    ),
                    _textButton(onTap: () => _append(" ^ "), label: "^", color: Colors.blueGrey),
                    _textButton(onTap: () => _append(" / "), label: "÷", color: Colors.blueGrey),
                  ],
                ),
                Row(
                  spacing: 4.0,
                  children: [
                    _textButton(onTap: () => _append("7"), label: "7"),
                    _textButton(onTap: () => _append("8"), label: "8"),
                    _textButton(onTap: () => _append("9"), label: "9"),
                    _textButton(onTap: () => _append(" * "), label: "*", color: Colors.blueGrey),
                  ],
                ),
                Row(
                  spacing: 4.0,
                  children: [
                    _textButton(onTap: () => _append("4"), label: "4"),
                    _textButton(onTap: () => _append("5"), label: "5"),
                    _textButton(onTap: () => _append("6"), label: "6"),
                    _textButton(onTap: () => _append(" - "), label: "-", color: Colors.blueGrey),
                  ],
                ),
                Row(
                  spacing: 4.0,
                  children: [
                    _textButton(onTap: () => _append("1"), label: "1"),
                    _textButton(onTap: () => _append("2"), label: "2"),
                    _textButton(onTap: () => _append("3"), label: "3"),
                    _textButton(onTap: () => _append(" + "), label: "+", color: Colors.blueGrey),
                  ],
                ),
                Row(
                  spacing: 4.0,
                  children: [
                    _textButton(onTap: () => _append("0"), label: "0"),
                    _textButton(onTap: () => _append("."), label: "."),
                    _iconButton(onTap: _backspace, label: Icons.backspace),
                    _textButton(onTap: _evaluate, label: "=", color: Colors.blueAccent),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _append(String character) {
    HapticFeedback.selectionClick();
    setState(() {
      if (appendOverrides || display == "0") {
        display = character;

        appendOverrides = false;
      } else {
        display += character;
      }
    });

    /// Basically, we treat just typing a single number an evaluation.
    if (expressionParser.parse(display) case ConstantExpression(:var value)) {
      widget.onEvaluate(value);
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

  void _evaluate() {
    var expression = expressionParser.parse(display);
    if (expression == null) {
      _error();
      return;
    }

    try {
      num value = expression.evaluate({});
      if (!value.isFinite) throw UnsupportedError("Values must be finite!");

      appendOverrides = true;
      _append(value.toStringAsFixedMax(3));
      widget.onEvaluate(value);
    } on UnsupportedError {
      _error();
      return;
    }
  }

  Widget _textButton({required void Function() onTap, required String label, Color? color}) {
    return Expanded(
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          padding: EdgeInsets.all(0),
          backgroundColor: color ?? Color(0xff444444),
        ),
        onPressed: onTap,
        label: Text(label),
      ),
    );
  }

  Widget _iconButton({required void Function() onTap, required IconData label, Color? color}) {
    return Expanded(
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          padding: EdgeInsets.all(0),
          backgroundColor: color ?? Color(0xff444444),
        ),
        onPressed: onTap,
        label: Icon(label),
      ),
    );
  }
}

extension on num {
  String toStringAsFixedMax(int fractionDigits) {
    var string = toStringAsFixed(fractionDigits).split("");
    var r = string.length - 1;
    while (string.length - r >= 0 && string[r] == "0") {
      r--;
    }

    if (string[r] == ".") {
      r--;
    }

    return string.sublist(0, r + 1).join("");
  }
}
