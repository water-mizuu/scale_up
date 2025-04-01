import "package:flutter/material.dart";
import "package:scale_up/presentation/views/authentication/widgets/lesson_tile.dart";

class OngoingLessonsContainer extends StatelessWidget {
  const OngoingLessonsContainer({
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
              "Ongoing Lessons",
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
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 8,
            children: <Widget>[
              LessonTile(
                label: "Distance",
                sublabel: "Unit 1",
                questionsDone: 7,
                questionsTotal: 10,
                icon: Icons.straighten,
                baseColor: Colors.pink,
              ),
              LessonTile(
                label: "Temperature",
                questionsDone: 7,
                questionsTotal: 10,
                baseColor: Colors.orange,
                icon: Icons.thermostat,
              ),
              LessonTile(
                label: "Temperature",
                questionsDone: 7,
                questionsTotal: 10,
                baseColor: Colors.green,
                icon: Icons.thermostat,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
