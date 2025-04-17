import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_practice_chapters.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_progression.dart";
import "package:scale_up/presentation/views/home/lesson_page/lesson_units.dart";
import "package:scale_up/utils/animated_scroll_controller.dart";

class LessonInformation extends StatelessWidget {
  const LessonInformation({super.key});

  @override
  Widget build(BuildContext context) {
    // I don't want to create a StatefulWidget just to use this controller.
    //   Thankfully, providers automatically dispose of the values.
    return InheritedProvider(
      create: (_) => AnimatedScrollController(),
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

class LessonInformationView extends StatelessWidget {
  const LessonInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
        spacing: 24.0,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [LessonProgression(), LessonUnits(), LessonPracticeChapters()],
      ),
    );
  }
}
