import "package:flutter/material.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/extensions/choose_random_extension.dart";
import "package:scale_up/utils/loading_tips.dart";

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(16.0) + const EdgeInsets.symmetric(horizontal: 48.0),
        child: Column(
          spacing: 8.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 12.0),
            Styles.subtitle("Loading..."),
            Styles.hint(loadingTips.chooseRandom(), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
