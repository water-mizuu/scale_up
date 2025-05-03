import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/learn_page/learn_page_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/colored_progress_bar.dart";

class LearnProgressBar extends StatelessWidget {
  const LearnProgressBar({super.key, required this.progressBarKey});

  final GlobalKey progressBarKey;

  @override
  Widget build(BuildContext context) {
    var learnPageBloc = context.watch<LearnPageBloc>();
    var LoadedLearnPageState(:progress, :lesson) = learnPageBloc.loadedState;
    var hslColor = lesson.hslColor;

    return ColoredProgressBar(
      progressBarKey: progressBarKey,
      progress: progress,
      hslColor: hslColor,
    );
  }
}
