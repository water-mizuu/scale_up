import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/presentation/views/home/practice_page/practice_progress_bar.dart";

class PracticeTopRow extends StatelessWidget {
  const PracticeTopRow({super.key, required this.progressBarKey});

  final GlobalKey<State<StatefulWidget>> progressBarKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.0,
      children: [
        IconButton(icon: const Icon(Icons.arrow_back_ios_new), onPressed: () => context.pop()),
        Expanded(child: PracticeProgressBar(progressBarKey: progressBarKey)),
      ],
    );
  }
}
