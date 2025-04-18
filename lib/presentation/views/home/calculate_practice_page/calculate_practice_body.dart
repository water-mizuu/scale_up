import "package:flutter/material.dart";
import "package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_event.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_state.dart";
import "package:scale_up/presentation/views/home/calculate_practice_page/calculator.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class CalculatePracticeBody extends StatelessWidget {
  const CalculatePracticeBody({required this.progressBarKey, super.key});

  final GlobalKey progressBarKey;

  @override
  Widget build(BuildContext context) {
    var chapterPageBloc = context.read<PracticePageBloc>();

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        spacing: 8.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 2, child: Instructions(progressBarKey: progressBarKey)),
          Expanded(
            flex: 5,
            child: BlocBuilder<PracticePageBloc, PracticePageState>(
              buildWhen: (p, n) => p.status == ChapterPageStatus.movingToNextQuestion,
              builder:
                  (_, _) => CalculatorWidget(
                    onEvaluate: (expression) {
                      chapterPageBloc.add(PracticePageInputChanged(expression));
                    },
                  ),
            ),
          ),
          const CheckButton(),
        ],
      ),
    );
  }
}

class Instructions extends StatelessWidget {
  const Instructions({super.key, required this.progressBarKey});

  final GlobalKey progressBarKey;

  @override
  Widget build(BuildContext context) {
    var chapterPageBloc = context.read<PracticePageBloc>();
    var state = chapterPageBloc.state as LoadedChapterPageState;
    var LoadedChapterPageState(:questions, :questionIndex) = state;
    var (left, right, number, _) = questions[questionIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CalculatePracticeProgressBar(progressBarKey: progressBarKey),
        const SizedBox(height: 12.0),
        Styles.subtitle(
          "Convert the unit from ${left.name} to ${right.name}",
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w400,
        ),
        Expanded(
          child: Center(
            child: Styles.title(
              "$number ${left.shortcut} to ___ ${right.shortcut}?",
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class CalculatePracticeProgressBar extends StatelessWidget {
  const CalculatePracticeProgressBar({super.key, required this.progressBarKey});

  final GlobalKey progressBarKey;

  @override
  Widget build(BuildContext context) {
    var PracticePageState(:progress) = context.read<PracticePageBloc>().state;
    if (progress == null) {
      return const SizedBox.shrink();
    }
    var hslColor = context.read<HSLColor>();

    return Ink(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: FAProgressBar(
        key: progressBarKey,
        currentValue: (progress * 100).floorToDouble(),
        borderRadius: BorderRadius.circular(24.0),
        progressColor: hslColor.toColor(),
        backgroundColor:
            hslColor
                .withLightness((hslColor.lightness + 0.25).clamp(0, 1))
                .withSaturation((hslColor.saturation) / 4)
                .toColor(),
        animatedDuration: const Duration(milliseconds: 150),
      ),
    );
  }
}

class CheckButton extends StatelessWidget {
  const CheckButton({super.key});

  @override
  Widget build(BuildContext context) {
    var chapterPageBloc = context.read<PracticePageBloc>();
    var hslColor = context.read<HSLColor>();
    var buttonColor =
        hslColor //
            .withHue((hslColor.hue + 180) % 360)
            .withSaturation((hslColor.saturation * 0.5).clamp(0, 1))
            .withLightness(0.45)
            .toColor();

    return BlocBuilder<PracticePageBloc, PracticePageState>(
      builder: (context, state) {
        return FilledButton(
          style: FilledButton.styleFrom(backgroundColor: buttonColor),
          onPressed:
              state.status == ChapterPageStatus.correct
                  ? null
                  : () {
                    chapterPageBloc.add(PracticePageAnswerSubmitted());
                  },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Text("Check", style: TextStyle(fontSize: 16.0)),
          ),
        );
      },
    );
  }
}
