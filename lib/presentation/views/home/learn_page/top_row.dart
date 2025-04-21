import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_progress_bar.dart";

class TopRow extends StatelessWidget {
  const TopRow({super.key, required this.progressBarKey});

  final GlobalKey<State<StatefulWidget>> progressBarKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.0,
      children: [
        IconButton(icon: const Icon(Icons.arrow_back_ios_new), onPressed: () => context.pop()),
        Expanded(child: LearnProgressBar(progressBarKey: progressBarKey)),
      ],
    );
  }
}
