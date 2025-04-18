import "package:flutter/material.dart";
import "package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_state.dart";

class PracticeProgressBar extends StatelessWidget {
  const PracticeProgressBar({super.key, required this.progressBarKey});

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
