import "package:flutter/material.dart";
import "package:scale_up/presentation/views/home/learn_page/top_row.dart";

class FinishedLearnPage extends StatelessWidget {
  const FinishedLearnPage({super.key, required this.progressBarKey});

  final GlobalKey<State<StatefulWidget>> progressBarKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TopRow(progressBarKey: progressBarKey),
          Expanded(
            child: Center(child: Text("Congratulations! You have completed all questions.")),
          ),
        ],
      ),
    );
  }
}
