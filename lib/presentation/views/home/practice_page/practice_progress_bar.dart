import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_state.dart";
import "package:scale_up/presentation/views/home/widgets/colored_progress_bar.dart";

class PracticeProgressBar extends StatelessWidget {
  const PracticeProgressBar({super.key, required this.progressBarKey});

  final GlobalKey progressBarKey;

  @override
  Widget build(BuildContext context) {
    var LoadedPracticePageState(:progress, :lesson) =
        context.read<PracticePageBloc>().loadedState;

    var hslColor = lesson.hslColor;

    return ColoredProgressBar(
      progressBarKey: progressBarKey,
      progress: progress,
      hslColor: hslColor,
    );
  }
}
