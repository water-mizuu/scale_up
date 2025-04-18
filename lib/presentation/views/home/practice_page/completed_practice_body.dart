import "package:flutter/material.dart";
import "package:scale_up/presentation/views/home/practice_page/practice_progress_bar.dart";

class CompletedPracticeBody extends StatelessWidget {
  const CompletedPracticeBody({required this.progressBarKey, super.key});

  final GlobalKey progressBarKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        spacing: 8.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PracticeProgressBar(progressBarKey: progressBarKey),
          Expanded(child: Center(child: Text("Congrats! You done bro"))),
        ],
      ),
    );
  }
}
