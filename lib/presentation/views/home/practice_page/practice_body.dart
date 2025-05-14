import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_event.dart";
import "package:scale_up/presentation/views/home/practice_page/calculator.dart";
import "package:scale_up/presentation/views/home/practice_page/practice_check_button.dart";
import "package:scale_up/presentation/views/home/practice_page/practice_instructions.dart";
import "package:scale_up/presentation/views/home/practice_page/practice_top_row.dart";
import "package:scale_up/utils/widgets/animated_slide_transition.dart";

class PracticeBody extends StatelessWidget {
  const PracticeBody({required this.progressBarKey, super.key});

  final GlobalKey progressBarKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PracticeTopRow(progressBarKey: progressBarKey),
            const PracticeInstructions(),
            Column(
              spacing: 24.0,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [_calculatorWidget(context), const PracticeCheckButton()],
            ),
          ],
        ),
      ),
    );
  }

  Widget _calculatorWidget(BuildContext context) {
    return AnimatedSlideTransition(
      delay: 120.ms,
      child: CalculatorWidget(
        hslColor: context.read<PracticePageBloc>().state.lesson!.hslColor,
        onInputChange: (expression) {
          try {
            var evaluated = expression?.evaluate({});

            context.read<PracticePageBloc>().add(PracticePageInputChanged(evaluated));
          } on UnsupportedError {
            context.read<PracticePageBloc>().add(const PracticePageInputChanged(null));
          }
        },
      ),
    );
  }
}
