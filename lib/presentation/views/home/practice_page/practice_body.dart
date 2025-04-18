import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_event.dart";
import "package:scale_up/presentation/views/home/practice_page/calculator.dart";
import "package:scale_up/presentation/views/home/practice_page/check_button.dart";
import "package:scale_up/presentation/views/home/practice_page/instructions.dart";

class PracticeBody extends StatelessWidget {
  const PracticeBody({required this.progressBarKey, super.key});

  final GlobalKey progressBarKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        spacing: 8.0,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Instructions(progressBarKey: progressBarKey),
          Column(
            spacing: 24.0,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CalculatorWidget(
                onEvaluate: (expression) {
                  context.read<PracticePageBloc>().add(PracticePageInputChanged(expression));
                },
              ),
              const CheckButton(),
            ],
          ),
        ],
      ),
    );
  }
}
