import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:scale_up/presentation/bloc/PracticePage/practice_page_bloc.dart";
import "package:scale_up/presentation/views/home/practice_page/practice_progress_bar.dart";
import "package:scale_up/presentation/views/home/widgets/confirming_leave_chapter_widget.dart";

class PracticeTopRow extends StatelessWidget {
  const PracticeTopRow({super.key, required this.progressBarKey});

  final GlobalKey<State<StatefulWidget>> progressBarKey;

  @override
  Widget build(BuildContext context) {
    var shouldConfirm = context.select((PracticePageBloc b) => b.loadedState.questionIndex > 0);

    return Row(
      spacing: 12.0,
      children: [
        ConfirmingLeaveChapterWidget(shouldConfirm: shouldConfirm),
        Expanded(child: PracticeProgressBar(progressBarKey: progressBarKey)),
      ],
    );
  }
}
