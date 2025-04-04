import "package:flutter/material.dart";
import "package:scale_up/presentation/views/home/home_page/featured_lesson.dart";

class FeaturedLessonsContainer extends StatelessWidget {
  const FeaturedLessonsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8.0,
      children: [
        Text("Daily Practice", style: TextStyle(fontWeight: FontWeight.bold)),
        FeaturedLesson(),
      ],
    );
  }
}
