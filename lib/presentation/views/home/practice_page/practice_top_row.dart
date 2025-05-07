import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:scale_up/hooks/use_provider_hooks.dart";
import "package:scale_up/presentation/bloc/practice_page/practice_page_bloc.dart";
import "package:scale_up/presentation/views/home/practice_page/practice_progress_bar.dart";
import "package:scale_up/presentation/views/home/widgets/confirming_leave_chapter_widget.dart";

class PracticeTopRow extends HookWidget {
  final GlobalKey<State<StatefulWidget>> progressBarKey;

  const PracticeTopRow({super.key, required this.progressBarKey});

  @override
  Widget build(BuildContext context) {
    var doneRef = useRef(0);
    var (questionIndex, done, total) = useSelect(
      (PracticePageBloc b) => (
        b.loadedState.questionIndex,
        b.loadedState.questionIndex - b.loadedState.mistakes + 1,
        b.loadedState.questions.length - b.loadedState.mistakes,
      ),
    );
    if (done > doneRef.value) doneRef.value = done;

    var shouldConfirm = questionIndex > 0;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 12.0,
            children: [
              ConfirmingLeaveChapterWidget(shouldConfirm: shouldConfirm),
              Row(
                children: [
                  const Icon(Icons.import_contacts),
                  const SizedBox(width: 8.0),
                  Text("${doneRef.value} of $total"),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          PracticeProgressBar(progressBarKey: progressBarKey),
        ],
      ),
    );
  }
}
