import "package:flutter/material.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_check_button.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_choices.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_instructions.dart";
import "package:scale_up/presentation/views/home/learn_page/learn_top_row.dart";

class LearnBody extends StatelessWidget {
  const LearnBody({super.key, required this.progressBarKey});

  final GlobalKey<State<StatefulWidget>> progressBarKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LearnTopRow(progressBarKey: progressBarKey),
            const Flexible(child: LearnInstructions()),
            const Column(
              spacing: 18.0,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [LearnChoices(), LearnCheckButton()],
            ),
          ],
        ),
      ),
    );
  }
}
