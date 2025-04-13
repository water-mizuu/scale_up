import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_information_view.dart";
import "package:scroll_animator/scroll_animator.dart";

class LessonInformation extends StatelessWidget {
  const LessonInformation({super.key});

  @override
  Widget build(BuildContext context) {
    // I don't want to create a StatefulWidget just to use this controller.
    //   Thankfully, providers automatically dispose of the values.
    return InheritedProvider(
      create: (_) => AnimatedScrollController(animationFactory: const ChromiumEaseInOut()),
      dispose: (_, v) => v.dispose(),
      builder:
          (context, child) => SingleChildScrollView(
            controller: context.read<AnimatedScrollController>(),
            child: child,
          ),
      child: LessonInformationView(),
    );
  }
}
