import "package:flutter/material.dart";
import "package:scale_up/presentation/views/authentication/widgets/lesson_tile.dart";

class FeaturedLessons extends StatelessWidget {
  const FeaturedLessons({super.key});

  @override
  Widget build(BuildContext context) {
    /// TODO: Base this featured lessons from something else.
    return LessonTile(
      label: "Area",
      questionsDone: 4,
      questionsTotal: 5,
      icon: Icons.square_foot,
      progressBarValue: 0.73,
      baseColor: Colors.blueAccent,
    );
  }
}
