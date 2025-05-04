import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/learn_page/learn_page_bloc.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_check_button.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_top_row.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class CompletedLearnBody extends StatelessWidget {
  const CompletedLearnBody({super.key, required this.progressBarKey});

  final GlobalKey<State<StatefulWidget>> progressBarKey;

  @override
  Widget build(BuildContext context) {
    var state = context.read<LearnPageBloc>().loadedState;
    var chapters = state.lesson.learnChapters;
    var currentChapter = chapters[state.chapterIndex];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LearnTopRow(progressBarKey: progressBarKey),
          Expanded(
            child: Center(
              child: Column(
                spacing: 8.0,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/illustrations/completed_1.png", width: 250),
                  Styles.subtitle("Congratulations!", fontSize: 26.0),
                  Styles.subtitle("You have finished '${currentChapter.name}'", fontSize: 14.0),
                ],
              ),
            ),
          ),
          const LearnCheckButton(),
        ],
      ),
    );
  }
}
