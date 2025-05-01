import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_bloc.dart";
import "package:scale_up/presentation/views/home/practice_page/practice_check_button.dart";
import "package:scale_up/presentation/views/home/practice_page/practice_top_row.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class CompletedPracticeBody extends StatelessWidget {
  const CompletedPracticeBody({required this.progressBarKey, super.key});

  final GlobalKey progressBarKey;

  @override
  Widget build(BuildContext context) {
    var state = context.read<PracticePageBloc>().loadedState;
    var chapters = state.lesson.practiceChapters;
    var currentChapter = chapters[state.chapterIndex];

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        spacing: 8.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PracticeTopRow(progressBarKey: progressBarKey),
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
          PracticeCheckButton(),
        ],
      ),
    );
  }
}
