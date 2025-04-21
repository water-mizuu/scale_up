import "package:flutter/material.dart";
import "package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/LearnPage/learn_page_bloc.dart";

class LearnProgressBar extends StatelessWidget {
  const LearnProgressBar({super.key, required this.progressBarKey});

  final GlobalKey progressBarKey;

  @override
  Widget build(BuildContext context) {
    var learnPageBloc = context.watch<LearnPageBloc>();
    var LoadedLearnPageState(:progress, :lesson) = learnPageBloc.loadedState;
    var hslColor = lesson.hslColor;

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
