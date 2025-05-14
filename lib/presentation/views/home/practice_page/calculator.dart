import "dart:async";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/numerical_expression.dart";
import "package:scale_up/data/sources/lessons/parsers/numerical_expression_parser.dart";
import "package:scale_up/hooks/use_bloc_listener.dart";
import "package:scale_up/hooks/use_provider_hooks.dart";
import "package:scale_up/presentation/bloc/learn_page/learn_page_bloc.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_state.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/extensions/hsl_color_scheme_extension.dart";
import "package:scale_up/utils/extensions/to_string_as_fixed_max_extension.dart";

class CalculatorWidget extends StatefulHookWidget {
  const CalculatorWidget({required this.onInputChange, required this.hslColor, super.key});

  final HSLColor hslColor;
  final FutureOr<void> Function(NumericalExpression?) onInputChange;

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  // Theme variables
  late final HSLColor hslColor;
  late final Color backgroundColor;
  late final Color neutralColor;
  late final Color accentColor;
  late final Color equalsColor;

  // Calculator state
  late final NumericalExpressionParser expressionParser;
  late String display;
  late bool appendOverrides;

  // Spacing constants - REDUCED FOR COMPACT LAYOUT
  final double buttonSpacing = 3.0;
  final double rowSpacing = 3.0;
  final double containerPadding = 8.0;
  final double buttonSize = 40.0; // Reduced from 60.0

  @override
  void initState() {
    super.initState();

    // Initialize parser and display
    expressionParser = NumericalExpressionParser();
    display = "0";
    appendOverrides = false;

    // Get theme color from the bloc
    hslColor = widget.hslColor;

    // Configure color theme
    backgroundColor =
        hslColor.withSaturation(hslColor.saturation * 0.5).withLightness(0.95).toColor();

    neutralColor =
        hslColor
            .withSaturation((hslColor.saturation * 0.12).clamp(0, 1))
            .withLightness(0.3)
            .toColor();

    final accent = hslColor.withSaturation(hslColor.saturation * 0.5);
    accentColor = accent.withLightness((hslColor.lightness + 0.05).clamp(0, 1)).toColor();
    equalsColor = accent.withLightness((hslColor.lightness + 0.1).clamp(0, 1)).toColor();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    /// A disgusting hack. Someone should rewrite this better.
    if (useMaybeRead<PracticePageBloc>() case var practicePageBloc?) {
      useBlocListener(practicePageBloc, (state) {
        if (state.status == PracticePageStatus.evaluating) {
          _evaluate(submit: false);
        }
        if (state.status == PracticePageStatus.movingIn) {
          _clear();
        }
      });
    } else if (useMaybeRead<LearnPageBloc>() case var learnPageBloc?) {
      useBlocListener(learnPageBloc, (state) {
        if (state is! LoadedLearnPageState) return;

        if (state.status == LearnPageStatus.evaluating) {
          _evaluate(submit: false);
        }
        if (state.status == LearnPageStatus.movingIn) {
          _clear();
        }
      }, listenWhen: (_, c) => c is LoadedLearnPageState);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [backgroundColor, backgroundColor.withValues(alpha: 0.92)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: hslColor.borderColor.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: hslColor.withAlpha(0.08).toColor(),
              blurRadius: 6.0,
              offset: const Offset(0, 2),
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Calculator display
            _buildDisplay(),
            const SizedBox(height: 10.0),

            // Calculator buttons
            _buildKeypad(isSmallScreen),

            // Hint text - Made smaller and more stylish
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lightbulb_outline, size: 14.0, color: Styles.hint.color),
                  const SizedBox(width: 4.0),
                  Styles.hint("Compute your answer here!", fontSize: 14.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplay() {
    return Container(
      height: 48.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white.withValues(alpha: 0.95)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 2.0,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: AbsorbPointer(
        absorbing: true,
        child: IgnorePointer(
          child: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Text(
              display,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKeypad(bool isSmallScreen) {
    final combinedRow = _buildCombinedFunctionRow(isSmallScreen);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        combinedRow,
        SizedBox(height: rowSpacing),

        _buildButtonRow([
          _buildButton(text: "7", onTap: () => _append("7")),
          _buildButton(text: "8", onTap: () => _append("8")),
          _buildButton(text: "9", onTap: () => _append("9")),
          _buildButton(text: "×", onTap: () => _append("*")),
        ], isSmallScreen),
        SizedBox(height: rowSpacing),
        _buildButtonRow([
          _buildButton(text: "4", onTap: () => _append("4")),
          _buildButton(text: "5", onTap: () => _append("5")),
          _buildButton(text: "6", onTap: () => _append("6")),
          _buildButton(text: "-", onTap: () => _append("-")),
        ], isSmallScreen),
        SizedBox(height: rowSpacing),
        _buildButtonRow([
          _buildButton(text: "1", onTap: () => _append("1")),
          _buildButton(text: "2", onTap: () => _append("2")),
          _buildButton(text: "3", onTap: () => _append("3")),
          _buildButton(text: "+", onTap: () => _append("+")),
        ], isSmallScreen),
        SizedBox(height: rowSpacing),
        _buildButtonRow([
          _buildButton(text: "0", onTap: () => _append("0")),
          _buildButton(text: ".", onTap: () => _append(".", replacesZero: false)),
          _buildButton(icon: Icons.backspace_outlined, onTap: _backspace, iconSize: 16),
          _buildButton(text: "=", onTap: _evaluate, color: equalsColor),
        ], isSmallScreen),
      ],
    );
  }

  Widget _buildCombinedFunctionRow(bool isSmallScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 1.0 : buttonSpacing / 2),
            child: _buildButton(text: "AC", onTap: _clear, color: accentColor),
          ),
        ),

        Expanded(
          flex: 5,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: buttonSpacing / 2),
                  child: _buildButton(text: "(", onTap: () => _append("(")),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: buttonSpacing / 2),
                  child: _buildButton(text: ")", onTap: () => _append(")")),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: buttonSpacing / 2),
                  child: _buildButton(text: "^", onTap: () => _append("^")),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: buttonSpacing / 2),
                  child: _buildButton(text: "÷", onTap: () => _append("/")),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtonRow(List<Widget> buttons, bool isSmallScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          buttons.map((button) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 1.0 : buttonSpacing / 2,
                ),
                child: button,
              ),
            );
          }).toList(),
    );
  }

  Widget _buildButton({
    String? text,
    IconData? icon,
    required Function() onTap,
    Color? color,
    double? iconSize,
  }) {
    final buttonColor = color ?? neutralColor;
    final isOperator = text != null && ["+", "-", "×", "÷", "^", "="].contains(text);
    final isNumber =
        text != null && ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."].contains(text);

    return SizedBox(
      height: buttonSize,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 2,
          shadowColor: buttonColor.withValues(alpha: 0.4),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [buttonColor.withValues(alpha: 0.8), buttonColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: buttonColor.withValues(alpha: 0.15),
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Center(
            child: Builder(
              builder: (context) {
                if (icon != null) {
                  return Icon(icon, size: iconSize ?? 16);
                }
                return Text(
                  text!,
                  style: TextStyle(
                    fontSize: isOperator ? 16.0 : (isNumber ? 15.0 : 14.0),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // Logic to append a character to the display
  void _append(String character, {bool replacesZero = true, bool submit = true}) {
    HapticFeedback.selectionClick();
    setState(() {
      if (appendOverrides || (display == "0" && replacesZero)) {
        display = character;

        if (appendOverrides) {
          appendOverrides = false;
        }
      } else {
        final lastChar = getLastCharacter(display.trimRight());
        final isLastCharacterDigit = display.isNotEmpty && lastChar.isDigitOrDot;
        final isCharacterDigitOrDot = character.isDigitOrDot;

        // If the last character is a digit, and the current character is a digit,
        // then we should just append it plainly.
        if (isLastCharacterDigit && isCharacterDigitOrDot) {
          display = display.trimRight();
          display += character;
        }
        // If the last character is NOT a digit (i.e. an operator),
        // Then we should append space.
        else if (!isLastCharacterDigit || !isCharacterDigitOrDot) {
          display = display.trimRight();
          display += " ";
          display += character;
        }
      }
    });

    // Evaluate expression after each input
    if (submit) {
      final expression = expressionParser.parse(display);
      widget.onInputChange(expression);
    }
  }

  String getLastCharacter(String text) {
    if (text.isEmpty) return "";
    return text[text.length - 1];
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
    final expression = expressionParser.parse(display.trim());
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
        widget.onInputChange(expression);
      }
    } on UnsupportedError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      _error();
      if (submit) {
        widget.onInputChange(null);
      }
      return;
    }
  }
}

extension on String {
  bool get isDigitOrDot {
    return int.tryParse(this) != null || this == ".";
  }
}
