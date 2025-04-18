import "package:flutter/material.dart";
import "package:scale_up/presentation/views/home/"
    "calculate_practice_page/calculate_practice_body.dart";

class CompletedCalculatePracticeBody extends StatelessWidget {
  const CompletedCalculatePracticeBody({required this.progressBarKey, super.key});

  final GlobalKey progressBarKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        spacing: 8.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CalculatePracticeProgressBar(progressBarKey: progressBarKey),
          Expanded(child: Center(child: Text("Congrats! You done bro"))),
        ],
      ),
    );
  }
}
