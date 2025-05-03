import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_event.dart";
import "package:scale_up/presentation/views/home/practice_page/calculator.dart";
import "package:scale_up/presentation/views/home/practice_page/practice_check_button.dart";
import "package:scale_up/presentation/views/home/practice_page/practice_instructions.dart";
import "package:scale_up/presentation/views/home/practice_page/practice_top_row.dart";

class PracticeBody extends StatelessWidget {
  const PracticeBody({required this.progressBarKey, super.key});

  final GlobalKey progressBarKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PracticeTopRow(progressBarKey: progressBarKey),
          PracticeInstructions(),
          Column(
            spacing: 24.0,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CalculatorWidget(
                onEvaluate: (expression) {
                  context.read<PracticePageBloc>().add(PracticePageInputChanged(expression));
                },
              ),
              const PracticeCheckButton(),
            ],
          ),
        ],
      ),
    );
  }
}
