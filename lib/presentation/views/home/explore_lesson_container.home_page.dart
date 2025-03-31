import "package:flutter/material.dart";
import "package:scale_up/presentation/views/authentication/widgets/lesson_tile.dart";

class ExploreLessonsContainer extends StatelessWidget {
  const ExploreLessonsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.0,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Explore New Lessons",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(onPressed: () {}, child: Text("See All")),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 8,
            children: [
              LessonTile(
                label: "Placeholder",
                questionsDone: 7,
                questionsTotal: 10,
                icon: Icons.straighten,
                progressBarValue: 0.0,
                baseColor: Colors.blueAccent,
              ),
              LessonTile(
                label: "Placeholder 3",
                sublabel: "Sublabel what if i have a long subtitle",
                questionsDone: 7,
                questionsTotal: 10,
                icon: Icons.thermostat,
                progressBarValue: 0.0,
                baseColor: Colors.blueAccent,
              ),
              LessonTile(
                label: "Placeholder 2",
                sublabel: "Sublabel what if i have a long subtitle",
                questionsDone: 7,
                questionsTotal: 10,
                icon: Icons.thermostat,
                progressBarValue: 1.0,
                baseColor: Colors.blueAccent,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
